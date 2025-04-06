# ========================
# Configuration du provider AWS
# ========================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ========================
# Groupe de sécurité pour SSH et Docker Swarm
# ========================
resource "aws_security_group" "swarm-cluster" {
  name        = "swarm-cluster-sg"
  description = "Allow traffic for Docker Swarm cluster"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ===============================
# Déploiement des instances EC2 pour le cluster Docker Swarm
# ===============================
resource "aws_instance" "swarm" {
  count         = var.instance_count
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.swarm-cluster.id]

  root_block_device {
    volume_size = var.instance_disk_size
    volume_type = var.instance_disk_type
    delete_on_termination = true
  }  

  tags = {
    Name  = "plank-instance-${count.index}"
    Role  = count.index == 0 ? "master" : "node"
    Owner = "PLANK"
  }
}

# ===============================
# Construction d’une map avec des noms explicites pour les IP publiques
# ===============================
locals {
  nodes = {
    master    = aws_instance.swarm[0].public_ip
    worker-1  = aws_instance.swarm[1].public_ip
    worker-2  = aws_instance.swarm[2].public_ip
  }
}

# ===============================
# Tempo pour que chaque machine soit accessible en SSH avant d’exécuter Ansible
# ===============================
resource "null_resource" "wait_for_ssh" {
  for_each = local.nodes

  connection {
    type        = "ssh"
    host        = each.value
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${each.key} est accessible en SSH ${each.value}"
    ]
  }
}

# ===============================
# Exécution locale du playbook Ansible
# ===============================
resource "null_resource" "ansible_apply" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Lancement du playbook Ansible"

      LOG_FILE="../ansible-aws/logs/deploy_$(date +%Y%m%d_%H%M%S).log"

      ANSIBLE_FORCE_COLOR=true \
      ANSIBLE_CONFIG=../ansible-aws/ansible.cfg \
      ansible-playbook ../ansible-aws/docker-swarm.yml \
      | tee $LOG_FILE

      echo "Playbook Ansible terminé. Logs enregistrés dans $LOG_FILE"
    EOT

    working_dir = "${path.module}"
  }

  depends_on = [
    null_resource.wait_for_ssh
  ]
}
