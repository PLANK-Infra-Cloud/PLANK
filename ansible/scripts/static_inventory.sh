#!/bin/bash

# Répertoire où se trouve ton state Terraform
TERRAFORM_DIR="../../infrastructure/aws"
STATE_FILE="$TERRAFORM_DIR/terraform.tfstate"
INVENTORY_FILE="../inventory.yml"

echo "Récupération des IP DNS depuis $TERRAFORM_DIR"

# Vérifie que jq est installé
if ! command -v jq &> /dev/null; then
  echo "Erreur : jq est requis. Installe-le avec : sudo apt install jq"
  exit 1
fi

# Vérifie que le fichier de state Terraform existe
if [ ! -f "$STATE_FILE" ]; then
  echo "Erreur : fichier de state Terraform introuvable à : $STATE_FILE"
  echo "Exécute d'abord : terraform apply"
  exit 1
fi

# Récupère l'output ansible_inventory_json (DNS public)
INVENTORY_JSON=$(terraform -chdir="$TERRAFORM_DIR" output -raw ansible_inventory_json 2>/dev/null)

if [ -z "$INVENTORY_JSON" ]; then
  echo "Erreur : l'output 'ansible_inventory_json' est vide ou non défini."
  exit 1
fi

# Génère le fichier inventory.yml statique
echo "---" > "$INVENTORY_FILE"
echo "all:" >> "$INVENTORY_FILE"
echo "  hosts:" >> "$INVENTORY_FILE"

echo "$INVENTORY_JSON" | jq -r 'to_entries[] | "    \(.key):\n      ansible_host: \(.value)\n      ansible_user: ubuntu"' >> "$INVENTORY_FILE"

echo "Inventaire statique généré dans : $INVENTORY_FILE"
