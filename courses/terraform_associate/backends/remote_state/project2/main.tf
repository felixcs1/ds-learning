
terraform {

}

provider "aws" {
  region  = "eu-west-2"
  profile = "personal"
}


data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../project1/terraform.tfstate"
  }
}



module "ec2-example-module" {
  source            = "felixcs1/ec2-example-module/aws"
  version           = "> 0.0.1"
  instance_name     = "Felix's New Instance"
  aws_instance_type = "t2.micro"

  # Getting outputs from other state
  msg           = "VPC FROM PROJECT" # ! ${data.terraform_remote_state.vpc.outputs.vpc_id}"
  key_pair_name = "instance_key_pair"
  egress_ports  = [22, 80]

}


# output "name" {
#   value = "VPC FROM PROJECT ! ${data.terraform_remote_state.vpc.outputs.vpc_id}"
# }