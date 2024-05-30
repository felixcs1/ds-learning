
terraform {
  backend "s3" {
    bucket = "terraform-state-010203040"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    profile = "personal"
    dynamodb_endpoint = "force-unlock-terraform"
  }
}

provider "aws" {
  region  = "eu-west-2"
  profile = "personal"
}


module "ec2-example-module" {
  source            = "felixcs1/ec2-example-module/aws"
  version           = "> 0.0.1"
  instance_name     = "Felix's New Instance"
  aws_instance_type = "t2.micro"

  # Getting outputs from other state
  msg           = "HELLO WORLD"
  key_pair_name = "instance_key_pair"
  egress_ports  = [22, 80]

}



# terraform {
#   cloud {
#     organization = "felix_personal"

#     workspaces {
#       name = "getting-started"
#     }
#   }

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "5.35.0"
#     }
#   }

#   required_version = ">=1.7.0"
# }