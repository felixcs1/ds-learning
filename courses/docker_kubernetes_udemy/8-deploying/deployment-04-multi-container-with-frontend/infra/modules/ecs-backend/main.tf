locals {
  service_name = "${var.app_name}-service"
}


resource "aws_cloudwatch_log_group" "app" {
  name = "/ecs/${local.service_name}"

  retention_in_days = 14
}


resource "aws_cloudwatch_log_group" "db_logs" {
  name = "/ecs/monogodb"

  retention_in_days = 14
}


resource "aws_ecs_task_definition" "this" {
  family = "${var.app_name}-task"

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.task_cpu
  memory = var.task_memory

  # Needed for logs / ECR etc when using fargate. With EC2 its expected
  # you have the roles for logs and ECR on the instances
  # Gives the ECS service permission to do things like read an image from an ECR repository, and lookup secrets in SecretsManager
  execution_role_arn = var.ecs_execution_role_arn

  # Only required if enable_execute_command = true in the service
  # gives the software running inside the ECS task/container permission to access AWS resources.
  # For e.g EFS
  task_role_arn = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "mongodb-container"
      image     = "mongo"
      cpu       = 10
      memory    = 512
      essential = false # Required for it to be a dependency of the app container
      portMappings = [
        {
          containerPort = 27017
        }
      ]
      environment = [
        {
          name  = "MONGO_INITDB_ROOT_USERNAME"
          value = "felix"
        },
        {
          name  = "MONGO_INITDB_ROOT_PASSWORD"
          value = "secret"
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-region        = var.aws_region
          awslogs-group         = aws_cloudwatch_log_group.db_logs.name
          awslogs-stream-prefix = local.service_name
        }
      }
      mountPoints: [
        {
          sourceVolume: "efs-persist",
          containerPath: "/data/db"
        }
      ]
    },
    {
      name  = "${var.app_name}-container"
      image = "${var.image_name}:${var.image_tag}"

      cpu       = 10
      memory    = 512
      essential = true # need at least on essential container
      command   = ["node", "app.js"]
      portMappings = [
        {
          containerPort = 3000
        },
      ]
      environment = [
        {
          name  = "MONGODB_URL"
          value = "localhost"
        },
        {
          name  = "MONGODB_USERNAME"
          value = "felix"
        },
        {
          name  = "MONGODB_PASSWORD"
          value = "secret"
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-region        = var.aws_region
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-stream-prefix = local.service_name
        }
      }
    },
  ])


  # N.B to see this EFS volumen work you need to shut down all tasks (desired task to 0)
  # This is because you cant have 2 mongodb tasks writing to the exact same folder in EFS
  volume {
    name = "efs-persist"

    efs_volume_configuration {
      file_system_id = aws_efs_file_system.efs_volume.id
      root_directory = "/"
    }
  }
}


resource "aws_ecs_service" "this" {
  name            = "${local.service_name}"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  # enables `aws ecs execute-command` cli commands against containers
  # requires task_role_arn in task definition 
  enable_execute_command = true

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.ecs_egress_all.id,
      aws_security_group.ingress_api.id
    ]
    subnets = var.private_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "${var.app_name}-container"
    container_port   = 3000
  }
}
