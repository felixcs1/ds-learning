

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

  # CPU value       Memory value (MiB)
  # 256 (.25 vCPU)  512 (0.5GB), 1024 (1GB), 2048 (2GB)
  # 512 (.5 vCPU)   1024 (1GB), 2048 (2GB), 3072 (3GB), 4096 (4GB)
  # 1024 (1 vCPU)   2048 (2GB), 3072 (3GB), 4096 (4GB), 5120 (5GB), 6144 (6GB), 7168 (7GB), 8192 (8GB)
  # 2048 (2 vCPU)   Between 4096 (4GB) and 16384 (16GB) in increments of 1024 (1GB)
  # 4096 (4 vCPU)   Between 8192 (8GB) and 30720 (30GB) in increments of 1024 (1GB)
  cpu    = var.task_cpu
  memory = var.task_memory

  # Needed for logs / ECR etc when using fargate. With EC2 its expected
  # you have the roles for logs and ECR on the instances
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${var.image_name}:${var.image_tag}"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        {
          name  = "SOME_ENV_VAR"
          value = "some_value"
        }
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
    {
      name      = var.container_name
      image     = "${var.image_name}:${var.image_tag}"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        {
          name  = "SOME_ENV_VAR"
          value = "some_value"
        }
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
  launch_type = "FARGATE"

  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.egress_all.id,
      aws_security_group.ingress_api.id
    ]
    subnets         = module.vpc.private_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = 3000
  }
}