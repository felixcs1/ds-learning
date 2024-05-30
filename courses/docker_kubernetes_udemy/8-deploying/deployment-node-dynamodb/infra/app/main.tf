locals {
  app_name       = "dynamo-app"
  vpc_name       = "felix-vpc-dynamo-app"
  ecr_repo_name  = "dynamo-app-repo"
  image_tag      = "latest"
  container_port = 3000
  region         = "eu-west-2"
  task_cpu       = 256
  task_memory    = 512
}


module "ecs_cluster" {
  source = "./modules/ecs"

  vpc_name            = local.vpc_name
  ecr_repo_name       = local.ecr_repo_name
  container_port      = local.container_port
  app_name            = local.app_name
  image_tag           = local.image_tag
  aws_region          = local.region
  task_cpu            = local.task_cpu
  task_memory         = local.task_memory
}


# Other things 

# data "aws_caller_identity" "current" {}

# Can get vpc stuff from data for e,g 
# data "aws_vpc" "main" {
#   state = "available"

#   tags = {
#     Name = var.vpc_name
#   }
# }

# data "aws_subnets" "private" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.main.id]
#   }

#   # TODO We should have the Private tag set to true `Private = "true"` and use it instead of searching by name
#   tags = {
#     Name = "${var.vpc_name} Private Subnet ${var.region}*"
#   }
# }