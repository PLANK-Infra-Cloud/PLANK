variable "ami" {
  description = "AMI ID pour les instances EC2"
  type        = string
}

variable "EC2_instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3a.large"
}

variable "public_subnet_id" {
  description = "ID du sous-réseau public"
  type        = string
}

variable "EC2_security_group" {
  description = "Groupe de sécurité des instances EC2"
  type        = string
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
}

variable "vpc_name" {
  description = "Nom du VPC"
  type        = string
}

variable "key_name" {
  description = "Nom de la clé SSH utilisée pour les EC2"
  type        = string
}

variable "efs_dns_name" {
  description = "DNS de l’EFS à monter sur les nœuds"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Chemin vers la clé privée pour SSH"
  type        = string
}

variable "instance_disk_size" {
  description = "Taille du disque root des instances EC2 (en GiB)"
  type        = number
  default     = 20
}

variable "instance_disk_type" {
  description = "Type de disque root des instances EC2"
  type        = string
  default     = "gp3"
}

# variable "ssh_private_key_content" {
#   description = "Contenu de la clé privée SSH"
#   type        = string
#   sensitive   = true
# } 