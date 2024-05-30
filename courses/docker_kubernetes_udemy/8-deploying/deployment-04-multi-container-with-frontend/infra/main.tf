locals {
  app_name    = "goals-app"
  image_tag   = "latest"
  region      = "eu-west-2"
  task_cpu    = 256
  task_memory = 512
}


data "aws_availability_zones" "available_zones" {
  state = "available"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.app_name}-vpc"
  cidr = "10.0.0.0/16"

  # For multiple AZs (slower to deploy)
  azs             = data.aws_availability_zones.available_zones.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # cant have just one for alb
  # azs             = ["eu-west-2a"]
  # private_subnets = ["10.0.1.0/24"]
  # public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false # Not sure what this is so turn off 

  tags = {
    Terraform = "true"
  }
}


resource "aws_ecs_cluster" "my_cluster" {
  name = "${local.app_name}-cluster"
}


module "backend" {
  source = "./modules/ecs-backend"

  app_name    = "${local.app_name}-backend"
  image_name  = "felixsteph/goals-node"
  image_tag   = local.image_tag
  
  cluster_id      = aws_ecs_cluster.my_cluster.id
  vpc_id          = module.vpc.vpc_id
  private_subnets = tolist(module.vpc.private_subnets)
  public_subnets  = tolist(module.vpc.public_subnets)

  aws_region  = local.region
  task_cpu    = local.task_cpu
  task_memory = local.task_memory

  ecs_execution_role_arn = aws_iam_role.ecs_execution_role.arn
  ecs_task_role_arn      = aws_iam_role.ecs_task_role.arn
}


module "frontend" {
  source = "./modules/ecs-frontend"

  app_name    = "${local.app_name}-frontend"
  image_name  = "felixsteph/goals-react"
  image_tag   = local.image_tag

  cluster_id      = aws_ecs_cluster.my_cluster.id
  vpc_id          = module.vpc.vpc_id
  private_subnets = tolist(module.vpc.private_subnets)
  public_subnets  = tolist(module.vpc.public_subnets)

  aws_region  = local.region
  task_cpu    = local.task_cpu
  task_memory = local.task_memory

  ecs_execution_role_arn = aws_iam_role.ecs_execution_role.arn
  ecs_task_role_arn      = aws_iam_role.ecs_task_role.arn
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