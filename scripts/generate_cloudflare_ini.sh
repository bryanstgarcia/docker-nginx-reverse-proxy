#!/bin/bash

# Carga las variables del archivo .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Verifica que la variable CLOUDFLARE_API_TOKEN esté definida
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "Error: La variable CLOUDFLARE_API_TOKEN no está definida en el archivo .env."
  exit 1
fi

# Ruta del archivo de credenciales
CLOUDFLARE_INI="./cloudflare.ini"

# Crea el archivo cloudflare.ini con el token de la API
echo "dns_cloudflare_api_token = $CLOUDFLARE_API_TOKEN" > "$CLOUDFLARE_INI"

# Cambia los permisos para que solo el propietario pueda leerlo
chmod 600 "$CLOUDFLARE_INI"

echo "Archivo cloudflare.ini generado correctamente en $CLOUDFLARE_INI"
