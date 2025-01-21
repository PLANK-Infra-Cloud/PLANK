# Security Group pour les instances Web Server
resource "aws_security_group" "web_server" {
  name        = "${var.project_name}-${var.vpc_name}-SG-EC2-WebServer"
  vpc_id      = var.vpc_id
  description = "Security group for Web Server instance"

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
    Name = "${var.project_name}-${var.vpc_name}-SG-EC2-WebServer"
  }
}

# Security Group pour les instances Database Server
resource "aws_security_group" "db_server" {
  name        = "${var.project_name}-${var.vpc_name}-SG-EC2-DbServer"
  vpc_id      = var.vpc_id
  description = "Security group for Database Server instance"

  ingress {
    description = "Allow MySQL traffic from Web Server"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.web_server.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.vpc_name}-SG-EC2-DbServer"
  }
}

# Security Group pour le Load Balancer Web
resource "aws_security_group" "lb_web" {
  name        = "${var.project_name}-${var.vpc_name}-SG-LB-WebServer"
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
    Name = "${var.project_name}-${var.vpc_name}-SG-LB-WebServer"
  }
}

# Security Group pour le Load Balancer Database
resource "aws_security_group" "lb_db" {
  name        = "${var.project_name}-${var.vpc_name}-SG-LB-DbServer"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow MySQL traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Exemple: Ajustez selon vos besoins
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.vpc_name}-SG-LB-DbServer"
  }
}
