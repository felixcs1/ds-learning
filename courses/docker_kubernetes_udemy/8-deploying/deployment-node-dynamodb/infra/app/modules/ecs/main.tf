locals {
  service_name = "${var.app_name}-service"
}


resource "aws_cloudwatch_log_group" "this" {
  name = "/ecs/${local.service_name}"
  retention_in_days = 14
}

resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family = local.service_name

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  # Total for all containers running
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
      name  = "${var.app_name}-container"
      image = "${data.aws_ecr_repository.this.repository_url}:${var.image_tag}"

      # single container so equal to task def overall cpu and mem
      cpu       = var.task_cpu
      memory    = var.task_memory
      # command   = ["node", "app.js"]
      portMappings = [
        {
          containerPort = var.container_port
        },
      ]
      environment = [
        {
          name  = "DYNAMODB_TABLE_NAME"
          value = aws_dynamodb_table.this.name
        },
        {
          name  = "AWS_REGION"
          value = var.aws_region
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-region        = var.aws_region
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-stream-prefix = local.service_name
        }
      }
    },
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = local.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  # enables `aws ecs execute-command` cli commands against containers
  # requires task_role_arn in task definition 
  enable_execute_command = true

  network_configuration {
    assign_public_ip = false # not required when using load balancer
    security_groups = [
      aws_security_group.ecs_egress_all.id,
      aws_security_group.ingress_api.id
    ]
    subnets = data.aws_subnets.private.ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "${var.app_name}-container"
    container_port   = var.container_port
  }
}