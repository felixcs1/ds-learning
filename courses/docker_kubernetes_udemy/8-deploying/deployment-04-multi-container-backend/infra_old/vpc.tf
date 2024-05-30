data "aws_availability_zones" "available_zones" {
  state = "available"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.app_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available_zones.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false # Not sure what this is so turn off 

  tags = {
    Terraform = "true"
  }
}


# For ALB
resource "aws_security_group" "http" {
  name        = "${var.app_name}-http"
  description = "HTTP traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# For ALB
resource "aws_security_group" "https" {
  name        = "${var.app_name}-https"
  description = "HTTPS traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# For ALB and ECS service
resource "aws_security_group" "egress_all" {
  name        = "${var.app_name}-egress-all"
  description = "Allow all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# For ECS service
resource "aws_security_group" "ingress_api" {
  name        = "${var.app_name}-ingress-api"
  description = "Allow ingress to API"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
