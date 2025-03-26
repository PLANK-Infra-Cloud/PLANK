resource "aws_efs_file_system" "efs" {
  creation_token = "${var.project_name}-${var.vpc_name}-efs"
  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-efs"
    Owner = "PLANK"
  }
}

resource "aws_efs_mount_target" "efs_mount" {
  for_each = toset(var.subnet_ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = [var.efs_security_group]
}