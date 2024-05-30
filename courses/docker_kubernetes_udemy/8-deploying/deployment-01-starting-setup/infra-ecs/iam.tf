# Execution role lifted from
# https://github.com/turnerlabs/terraform-ecs-fargate/blob/master/env/dev/ecs.tf#L162
# this could be generic to whole account and used everywhere
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.app_name}-ecs"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


