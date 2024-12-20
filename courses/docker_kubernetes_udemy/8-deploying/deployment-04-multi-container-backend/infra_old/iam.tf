# Execution role lifted from
# https://github.com/turnerlabs/terraform-ecs-fargate/blob/master/env/dev/ecs.tf#L162
# this could be generic to whole account and used everywhere

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


# Execution role
resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.app_name}-ecs"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# Task role
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.app_name}-ecs"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}


# Optional: This policy is just to be able to run aws ecs execute-command on the container
resource "aws_iam_policy" "ecs_container_access_policy" {
  name        = "allow-access-to-demand-score-api-key"
  description = "Allow Access to SSM Parameter"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_access_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_container_access_policy.arn
}
