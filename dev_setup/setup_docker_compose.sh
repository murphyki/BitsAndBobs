#!/bin/bash -eux

# See https://docs.docker.com/compose/install/

# Can pass in the specific version of docker-compose or use the default
COMPOSE_VERSION=${1:-"1.25.4"}

# Run this command to download the current stable release of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Test the installation
docker-compose --version
