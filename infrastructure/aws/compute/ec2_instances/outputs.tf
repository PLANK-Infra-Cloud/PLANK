output "EC2_id" {
  description = "ID of the Web Server instance"
  value       = aws_instance.EC2.id
}

output "EC2_public_ip" {
  description = "Public IP of the Web Server instance"
  value       = aws_instance.EC2.public_ip
}

output "EC2_private_ip" {
  description = "Private IP of the Database Server instance"
  value       = aws_instance.EC2.private_ip
}