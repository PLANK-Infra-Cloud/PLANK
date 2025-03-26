resource "aws_instance" "EC2" {
  ami           = "ami-0ff71843f814379b3" # Ubuntu 24.04
  instance_type = var.EC2_instance_type
  subnet_id     = var.public_subnet_id
  security_groups = [
    var.EC2_security_group
  ]

  tags = {
    Name = "${var.project_name}-${var.vpc_name}-EC2"
    Owner= "PLANK"
  }
}
