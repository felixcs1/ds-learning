module "aws_server" {
  source            = "./ec2_instance"
  aws_instance_type = "t2.micro"
  msg               = "HELLO WORLD"

  egress_ports = [22, 80]
}



resource "aws_s3_bucket" "new_imported_bucket" {
  bucket="new-bucket-to-import-with-tf"
}


output "ec2_public_dns" {
  value = module.aws_server.instance_public_dns
}


# My public example module 
# https://registry.terraform.io/modules/felixcs1/ec2-example-module/aws/latest?tab=resources
# module "ec2-example-module" {
#   source  = "felixcs1/ec2-example-module/aws"
#   version = "0.0.1"
#   aws_instance_type = "t2.micro"
#   msg               = "HELLO WORLD"
#   key_pair_name = "instance_key_pair"
#   egress_ports = [22, 80]
# }