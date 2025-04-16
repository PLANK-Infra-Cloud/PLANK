output "instance_sg_id" {
  description = "ID of the Security Group"
  value       = aws_security_group.instance_sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}