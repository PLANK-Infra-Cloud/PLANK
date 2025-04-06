# Affiche les IP publiques de chaque instance
output "instance_public_ips" {
  description = "Liste des IP publiques des instances EC2 du cluster Swarm"
  value       = aws_instance.swarm[*].public_ip
}

# Affiche les IP privées de chaque instance
output "instance_private_ips" {
  description = "Liste des IP privées des instances EC2 du cluster Swarm"
  value       = aws_instance.swarm[*].private_ip
}

# Affiche les noms et IPs formatés (public)
output "cluster_nodes" {
  description = "IP publiques nommées des nœuds du cluster"
  value = {
    master    = aws_instance.swarm[0].public_ip
    worker-1  = aws_instance.swarm[1].public_ip
    worker-2  = aws_instance.swarm[2].public_ip
  }
}

# Affiche les noms et IPs formatés (privé)
output "cluster_nodes_private" {
  description = "IP privées nommées des nœuds du cluster"
  value = {
    master    = aws_instance.swarm[0].private_ip
    worker-1  = aws_instance.swarm[1].private_ip
    worker-2  = aws_instance.swarm[2].private_ip
  }
}

# Export inventaire JSON pour Ansible statique (clé: nom, valeur: IP publique)
output "ansible_inventory_json" {
  description = "Inventaire Ansible statique en JSON (nom -> IP publique)"
  value       = jsonencode({
    master    = aws_instance.swarm[0].public_dns
    worker-1  = aws_instance.swarm[1].public_dns
    worker-2  = aws_instance.swarm[2].public_dns
  })
  sensitive   = false
}

# Affiche le nom du groupe de sécurité utilisé
output "security_group_name" {
  description = "Nom du groupe de sécurité appliqué aux instances"
  value       = aws_security_group.swarm-cluster.name
}
