variable "aws_instance_type" {
  default = "t2.micro"
  description = "Size of instance"

  validation {
    condition = can(regex("t2.*", var.aws_instance_type))
    error_message = "aws_instance_type must be t2.micro or t3.micro"
  }
}


variable "key_pair_name" {
    type = string
    default = "my_aws_key"
}

variable "key_file" {
    type = string
    default = "scripts/my_aws_key.pem"
}

variable "msg" {
  type = string
}

variable "egress_ports" {
  type = list
}

