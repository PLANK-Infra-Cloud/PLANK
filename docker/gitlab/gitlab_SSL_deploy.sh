#!/bin/bash

# Génère le certificat SSL
docker compose -f docker-compose.yml run --rm openssl

# Déploie GitLab
docker stack deploy -c docker-compose.yml gitlab