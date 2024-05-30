locals {
    app_name       = "goals-app"
    image_name     = "felixsteph/goals-node"
    image_tag      = "latest"
    region         = "eu-west-2"
    task_cpu       = 256
    task_memory    = 512
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



module "ecs_cluster" {
  source = "./modules/ecs"

  vpc_id          = module.vpc.vpc_id
  private_subnets = tolist(module.vpc.private_subnets)
  public_subnets  = tolist(module.vpc.public_subnets)

  app_name        = local.app_name
  image_name      = local.image_name
  image_tag       = local.image_tag
  aws_region      = local.region
  task_cpu        = local.task_cpu
  task_memory     = local.task_memory
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