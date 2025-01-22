#!/bin/bash

# Otorga permisos de ejecución al script 
chmod +x ./scripts/generate_cloudflare_ini.sh

# Genera el archivo cloudflare.ini
./scripts/generate_cloudflare_ini.sh

# Levanta los servicios de Docker Compose
sudo docker compose up -d
