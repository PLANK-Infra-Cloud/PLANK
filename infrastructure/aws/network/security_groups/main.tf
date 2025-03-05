# Security Group pour les instances Bastions
resource "aws_security_group" "bastion_instance" {
  name        = "${var.project_name}-${var.vpc_name}-SG-EC2-Bastion"
  vpc_id      = var.vpc_id
  description = "Security group for Bastion instance"

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.vpc_name}-SG-EC2-Bastion"
  }
}

# Security Group pour les instances Docker
resource "aws_security_group" "docker_instance" {
  name        = "${var.project_name}-${var.vpc_name}-SG-EC2-Docker"
  vpc_id      = var.vpc_id
  description = "Security group for Docker instance"

  # ingress {
  #   description = "Allow MySQL traffic from Bastion"
  #   from_port   = 3306
  #   to_port     = 3306
  #   protocol    = "tcp"
  #   security_groups = [aws_security_group.docker_instance.id]
  # }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.vpc_name}-SG-EC2-Docker"
  }
}

# Security Group pour le Load Balancer Bastion
resource "aws_security_group" "lb_bastion" {
  name        = "${var.project_name}-${var.vpc_name}-SG-LB-Bastion"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.vpc_name}-SG-LB-Bastion"
  }
}

# Security Group pour le Load Balancer Docker
resource "aws_security_group" "lb_docker" {
  name        = "${var.project_name}-${var.vpc_name}-SG-LB-Docker"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow MySQL traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # A ajuster selon les besoins
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.vpc_name}-SG-LB-Docker"
  }
}
