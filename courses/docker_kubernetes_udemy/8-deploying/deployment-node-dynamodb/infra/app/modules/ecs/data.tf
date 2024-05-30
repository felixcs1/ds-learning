data "aws_ecr_repository" "this" {
  name = var.ecr_repo_name
}


data "aws_vpc" "main" {
  state = "available"

  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Private = "true"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Public = "true"
  }
}