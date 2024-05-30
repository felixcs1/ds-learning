output "aws_ecs_service_arn" {
  value = aws_ecs_service.my_service.id
}

output "aws_private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "aws_public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "avzs" {
  value = data.aws_availability_zones.available_zones.names
}

output "alb_url" {
  value = "http://${aws_alb.this.dns_name}"
}