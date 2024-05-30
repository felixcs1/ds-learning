variable "service_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "task_cpu" {
  type    = number
  default = 256
}

variable "task_memory" {
  type    = number
  default = 512
}
