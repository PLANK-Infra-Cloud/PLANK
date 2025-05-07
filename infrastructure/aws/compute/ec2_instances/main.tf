resource "aws_instance" "master" {
  ami                    = var.ami
  instance_type          = var.EC2_instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.EC2_security_group]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nfs-common
              mkdir -p /mnt/efs
              for i in {1..10}; do
                echo "Tentative $i: vérification DNS EFS..."
                host ${var.efs_dns_name} && break
                sleep 10
              done
              sleep 20
              mount -t nfs4 -o nfsvers=4.1 ${var.efs_dns_name}:/ /mnt/efs
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
  key_name               = var.key_name

  user_data = aws_instance.master.user_data

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
  key_name               = var.key_name

  user_data = aws_instance.master.user_data

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
  key_name               = var.key_name

  tags = {
    Name  = "${var.project_name}-${var.vpc_name}-runner"
    Owner = "PLANK"
    Role  = "standalone-runner"
  }
}

locals {
  nodes = {
    master  = aws_instance.master.public_ip
    nodes1  = aws_instance.nodes1.public_ip
    nodes2  = aws_instance.nodes2.public_ip
  }
}

resource "null_resource" "wait_for_ssh" {
  for_each = local.nodes

  connection {
    type        = "ssh"
    host        = each.value
    user        = "ubuntu"
    private_key = var.ssh_private_key_content
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${each.key} est accessible en SSH ${each.value}"
    ]
  }
}


resource "null_resource" "ansible_apply" {
  provisioner "local-exec" {
    command = <<EOT
echo "Lancement du playbook Ansible"

LOG_FILE="../ansible/logs/deploy_$(date +%Y%m%d_%H%M%S).log"

ANSIBLE_FORCE_COLOR=true ANSIBLE_CONFIG=../ansible-aws/ansible.cfg \
ansible-playbook ../ansible/docker-swarm.yml | tee $LOG_FILE

echo "Playbook terminé. Logs : $LOG_FILE"
EOT
    working_dir = "${path.module}"
  }

  depends_on = [
    null_resource.wait_for_ssh
  ]
}
