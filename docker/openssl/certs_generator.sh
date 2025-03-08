#!/bin/bash

# Vérifie si le répertoire /certs existe déjà
if [ ! -d "/certs" ]; then
  # Crée le répertoire /certs
  mkdir /certs
  echo "Le répertoire /certs a été créé."
else
  echo "Le répertoire /certs existe déjà."
fi

# Génère le certificat SSL
docker compose -f docker-compose.yml run --rm openssl