terraform {
  
}

provider "aws" {
  region  = "eu-west-2"
  profile = "personal"
}

module "aws_server" {
  source            = "./terraform-aws-ec2-example-module"
  aws_instance_type = "t2.micro"
  instance_name     = "My Instance"
  msg               = "HELLO WORLD"
  key_pair_name = "instance_key_pair"
  egress_ports = [22, 80]
}


output "ec2_public_dns" {
  value = module.aws_server.instance_public_dns
}
