# Répertoires
ANSIBLE_DIR=.
TERRAFORM_DIR=../infrastructure/aws
SCRIPT_DIR=$(ANSIBLE_DIR)/scripts
LOG_DIR=$(ANSIBLE_DIR)/logs
INVENTORY_FILE=$(ANSIBLE_DIR)/inventory.yml
PRIVATE_KEY=~/.ssh/PLANK-key.pem

.PHONY: init plan apply destroy inventory ansible deploy log clean

## Initialiser Terraform
init:
	cd $(TERRAFORM_DIR) && terraform init

## Plan Terraform
plan:
	cd $(TERRAFORM_DIR) && terraform plan

## Appliquer le plan Terraform
apply:
	cd $(TERRAFORM_DIR) && terraform apply -auto-approve

## Détruire l'infrastructure
destroy:
	cd $(TERRAFORM_DIR) && terraform destroy -auto-approve

## Générer l'inventaire Ansible (statique)
inventory:
	cd $(SCRIPT_DIR) && ./static_inventory.sh

## Afficher le dernier log Ansible
log:
	@echo "Dernier log Ansible :"
	@ls -1t $(LOG_DIR)/deploy_*.log | head -n 1 | xargs cat

## Afficher la liste de tous les fichiers de logs Ansible
log-list:
	@echo "Liste des logs disponibles :"
	@ls -1t $(LOG_DIR)/deploy_*.log 2>/dev/null || echo "Aucun log trouvé."

## Nettoyer les fichiers temporaires
clean:
	@echo "Nettoyage des logs..."
	@rm -f $(LOG_DIR)/deploy_*.log
	@echo "Nettoyage des fichiers d'état Terraform..."
	@rm -f $(TERRAFORM_DIR)/*.tfstate*
