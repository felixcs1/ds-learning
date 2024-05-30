resource "aws_cloudwatch_log_group" "this" {
  name = "/ecs/${var.service_name}"

  retention_in_days = 14
}

resource "aws_ecs_cluster" "my_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "my_task" {
  family = var.service_name

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.task_cpu
  memory = var.task_memory

  # Needed for logs / ECR etc when using fargate. With EC2 its expected
  # you have the roles for logs and ECR on the instances
  # Gives the ECS service permission to do things like read an image from an ECR repository, and lookup secrets in SecretsManager
  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  # Only required if enable_execute_command = true in the service
  # gives the software running inside the ECS task/container permission to access AWS resources.
  # For e.g EFS
  task_role_arn = aws_iam_role.ecs_task_role.arn

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
    },
    {
      name  = var.container_name
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
      # Make sure db is accesible before backend trys to connect. Though for this 
      # app it didnt solve teh start up db connection error. In the end I needed to 
      # add connect retries in the app start up code
      dependsOn   = [{
        containerName = "mongodb-container"
        condition     = "START"
      }]
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
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-stream-prefix = var.service_name
        }
      }
    },
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  # enables `aws ecs execute-command` cli commands against containers
  # requires task_role_arn in task definition 
  enable_execute_command = true

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.egress_all.id,
      aws_security_group.ingress_api.id
    ]
    subnets = module.vpc.private_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = 3000
  }
}