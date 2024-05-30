terraform {
  backend "s3" {
    bucket = "terraform-state-010203040"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    profile = "personal"
  }
}

provider "aws" {
  region  = "eu-west-2"
  profile = "personal"
}


module "ec2-example-module" {
  source  = "felixcs1/ec2-example-module/aws"
  version = "> 0.0.1"
  instance_name = "Felix's Even Newer Instance"
  aws_instance_type = "t2.nano"
  msg               = "HELLO WORLD"
  key_pair_name = "instance_key_pair"
  egress_ports = [22, 80]
}