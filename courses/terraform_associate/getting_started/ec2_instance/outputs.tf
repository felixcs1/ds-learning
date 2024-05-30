output "instance_public_dns" {
  value = values(aws_instance.app_server)[*].public_dns
}