variable "aws_region" {
  description = "Région AWS de déploiement"
  type        = string
  default     = "eu-west-3"
}

variable "instance_count" {
  description = "Nombre d'instances EC2"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t2.micro"
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

variable "instance_ami" {
  description = "AMI Ubuntu 24.04 pour eu-west-3"
  type        = string
  default     = "ami-0160e8d70ebc43ee1"
}

variable "key_name" {
  description = "Nom de la clé SSH AWS existante"
  type        = string
  default     = "TFX-PLANK-AWS"
}

variable "ssh_private_key_path" {
  description = "Chemin vers la clé privée locale pour SSH"
  type        = string
  default     = "~/.ssh/TFX-PLANK-AWS.pem"
}