output "master_private_ip" {
  value = aws_instance.master.private_ip
}

output "nodes1_private_ip" {
  value = aws_instance.nodes1.private_ip
}

output "nodes2_private_ip" {
  value = aws_instance.nodes2.private_ip
}

output "master_public_ip" {
  description = "Adresse IP publique du master"
  value       = aws_instance.master.public_ip
}

output "nodes1_public_ip" {
  description = "Adresse IP publique de nodes1"
  value       = aws_instance.nodes1.public_ip
}

output "nodes2_public_ip" {
  description = "Adresse IP publique de nodes2"
  value       = aws_instance.nodes2.public_ip
}

output "swarm_nodes" {
  description = "Liste des IPs publiques des nœuds Docker Swarm"
  value = {
    master   = aws_instance.master.public_ip
    nodes1   = aws_instance.nodes1.public_ip
    nodes2   = aws_instance.nodes2.public_ip
  }
}
