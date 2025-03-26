resource "aws_security_group" "instance_sg" {
  name        = "${var.project_name}-${var.vpc_name}-SG-EC2"
  vpc_id      = var.vpc_id
  description = "Security group for EC2 instances"

  # Autoriser HTTP (port 80) depuis l'extérieur pour toutes les instances
  ingress {
    description = "Allow HTTP traffic from external"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser HTTPS depuis l'extérieur pour toutes les instances
  ingress {
    description = "Allow HTTPS traffic from external"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser SSH (port 22) depuis l'extérieur uniquement pour les instances
  ingress {
    description = "Allow SSH traffic from external"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser tout le trafic interne entre les instances EC2 dans le VPC
  ingress {
    description = "Allow full internal communication between instances"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

   # Autoriser tout le trafic sortant
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-SG-EC2"
    Owner = "PLANK"
  }
}



resource "aws_security_group" "efs_sg" {
  name        = "${var.project_name}-${var.vpc_name}-SG-EFS"
  description = "Allow NFS from EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port                = 2049
    to_port                  = 2049
    protocol                 = "tcp"
    security_groups          = [aws_security_group.instance_sg.id]
    description              = "Allow NFS from EC2 SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-SG-EFS"
    Owner = "PLANK"
  }
}
