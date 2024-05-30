output "aws_ecs_service_arn" {
  value = aws_ecs_service.my_service.id
}

output "alb_url" {
  value = "http://${aws_alb.this.dns_name}"
}