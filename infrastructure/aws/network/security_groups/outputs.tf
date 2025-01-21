output "bastion_instance_sg_id" {
  description = "ID of the Bastion Security Group"
  value       = aws_security_group.bastion_instance.id
}

output "docker_instance_sg_id" {
  description = "ID of the Docker Security Group"
  value       = aws_security_group.docker_instance.id
}

output "sg_bastion_lb_id" {
  description = "ID of the Bastion Load Balancer Security Group"
  value       = aws_security_group.lb_bastion.id
}

output "sg_docker_lb_id" {
  description = "ID of the Docker Load Balancer Security Group"
  value       = aws_security_group.lb_docker.id
}