resource "aws_efs_file_system" "efs_volume" {
  tags = {
    Name = "ECS-EFS-FS"
  }
}

resource "aws_efs_mount_target" "ecs_temp_space_az0" {
  file_system_id = aws_efs_file_system.efs_volume.id
  subnet_id      = module.vpc.private_subnets[0]
  security_groups = [aws_security_group.egress_all.id]
}