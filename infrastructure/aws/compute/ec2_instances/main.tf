resource "aws_instance" "master" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]
  key_name = var.key_name 

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nfs-common
              mkdir -p /mnt/efs
              # Attente DNS EFS (10 tentatives max)
              for i in {1..10}; do
                echo "Tentative $i: vérification DNS EFS..."
                host ${var.efs_dns_name} && break
                sleep 10
              done
              # Attente supplémentaire du service NFS
              sleep 20
              # Montage du système de fichiers EFS
              mount -t nfs4 -o nfsvers=4.1 ${var.efs_dns_name}:/ /mnt/efs
              # Persistance au redémarrage
              echo "${var.efs_dns_name}:/ /mnt/efs nfs4 defaults,_netdev 0 0" >> /etc/fstab
            EOF

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-master"
    Owner = "PLANK"
    Role  = "swarm-master"
  }
}

resource "aws_instance" "nodes1" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]
  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nfs-common
              mkdir -p /mnt/efs
              # Attente DNS EFS (10 tentatives max)
              for i in {1..10}; do
                echo "Tentative $i: vérification DNS EFS..."
                host ${var.efs_dns_name} && break
                sleep 10
              done
              # Attente supplémentaire du service NFS
              sleep 20
              # Montage du système de fichiers EFS
              mount -t nfs4 -o nfsvers=4.1 ${var.efs_dns_name}:/ /mnt/efs
              # Persistance au redémarrage
              echo "${var.efs_dns_name}:/ /mnt/efs nfs4 defaults,_netdev 0 0" >> /etc/fstab
            EOF

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-nodes1"
    Owner = "PLANK"
    Role  = "swarm-node"
  }
}

resource "aws_instance" "nodes2" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]
  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nfs-common
              mkdir -p /mnt/efs
              # Attente DNS EFS (10 tentatives max)
              for i in {1..10}; do
                echo "Tentative $i: vérification DNS EFS..."
                host ${var.efs_dns_name} && break
                sleep 10
              done
              # Attente supplémentaire du service NFS
              sleep 20
              # Montage du système de fichiers EFS
              mount -t nfs4 -o nfsvers=4.1 ${var.efs_dns_name}:/ /mnt/efs
              # Persistance au redémarrage
              echo "${var.efs_dns_name}:/ /mnt/efs nfs4 defaults,_netdev 0 0" >> /etc/fstab
            EOF

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-nodes2"
    Owner = "PLANK"
    Role  = "swarm-node"
  }
}

resource "aws_instance" "runner" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]
  key_name = var.key_name

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-runner"
    Owner = "PLANK"
    Role  = "standalone-runner"
  }
}