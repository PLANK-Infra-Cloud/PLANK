# resource "aws_instance" "web_server" {
#   ami           = "ami-0a094c309b87cc107" # Amazon Linux 2
#   instance_type = var.web_server_instance_type
#   subnet_id     = var.public_subnet_id
#   security_groups = [
#     var.web_server_security_group
#   ]

#   tags = {
#     Name = "${var.project_name}-${var.vpc_name}-WebServer"
#   }
# }

# resource "aws_instance" "db_server" {
#   ami           = "ami-0a094c309b87cc107" # Amazon Linux 2
#   instance_type = var.db_server_instance_type
#   subnet_id     = var.private_subnet_id
#   security_groups = [
#     var.db_server_security_group
#   ]

#   tags = {
#     Name = "${var.project_name}-${var.vpc_name}-DbServer"
#   }
# }# Test CI/CD Terraform
