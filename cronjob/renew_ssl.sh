#!/bin/bash

# Define the path to the Docker Compose file
USER_ROUTE="${HOME}"
PROJECT_FOLDER="${USER_ROUTE}/personal/docker-nginx-reverse-proxy"
COMPOSE_FILE_PATH="${USER_ROUTE}/docker-compose.yml"
echo "Esta es la ruta HOME ${HOME}"
echo "Esta es la ruta pwd $(pwd)"
# Find the path to the Docker Compose binary
DOCKER_COMPOSE_PATH=$(which docker-compose || which docker)

# Check if the Docker Compose binary exists
if [ -z "$DOCKER_COMPOSE_PATH" ]; then
    echo "Docker Compose binary not found." >&2
    exit 1
fi

# Check if the Docker Compose file exists
if [ ! -f "$COMPOSE_FILE_PATH" ]; then
    echo "Docker Compose file not found at $COMPOSE_FILE_PATH" >&2
    exit 1
fi

# Run Docker Compose
$DOCKER_COMPOSE_PATH -f "$COMPOSE_FILE_PATH" up -d cerbot

# Log the execution time
echo "Docker Compose run at $(date)" >> "$HOME/docker_compose.log"
