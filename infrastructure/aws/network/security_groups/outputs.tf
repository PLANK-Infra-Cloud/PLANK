output "web_server_sg_id" {
  description = "ID of the Web Server Security Group"
  value       = aws_security_group.web_server.id
}

output "db_server_sg_id" {
  description = "ID of the Database Server Security Group"
  value       = aws_security_group.db_server.id
}

output "sg_web_lb_id" {
  description = "ID of the Web Load Balancer Security Group"
  value       = aws_security_group.lb_web.id
}

output "sg_db_lb_id" {
  description = "ID of the Database Load Balancer Security Group"
  value       = aws_security_group.lb_db.id
}