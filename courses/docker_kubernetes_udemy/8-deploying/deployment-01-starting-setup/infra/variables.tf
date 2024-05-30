variable "instance_name" {
  type    = string
  default = "deploy-docker"
}

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "key_pair_name" {
  type    = string
  default = "my_aws_key"
}

variable "egress_ports" {
  type    = list(number)
  default = [443, 22]
}

variable "ingress_ports" {
  type    = list(number)
  default = [80, 22]
}