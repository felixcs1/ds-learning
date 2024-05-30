variable "vpc_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "private_subnets" {
  type = list
}

variable "public_subnets" {
  type = list
}

variable "app_name" {
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


# CPU value       Memory value (MiB)
# 256 (.25 vCPU)  512 (0.5GB), 1024 (1GB), 2048 (2GB)
# 512 (.5 vCPU)   1024 (1GB), 2048 (2GB), 3072 (3GB), 4096 (4GB)
# 1024 (1 vCPU)   2048 (2GB), 3072 (3GB), 4096 (4GB), 5120 (5GB), 6144 (6GB), 7168 (7GB), 8192 (8GB)
# 2048 (2 vCPU)   Between 4096 (4GB) and 16384 (16GB) in increments of 1024 (1GB)
# 4096 (4 vCPU)   Between 8192 (8GB) and 30720 (30GB) in increments of 1024 (1GB)
variable "task_cpu" {
  type    = number
  default = 256
}

variable "task_memory" {
  type    = number
  default = 512
}


variable "ecs_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}
