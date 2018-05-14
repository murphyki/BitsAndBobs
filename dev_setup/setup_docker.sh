#!/bin/bash -eux

# Install docker (Community Edition)
sudo apt-get install -y docker-ce

# Configure docker group
echo "Current user is: $USER"
sudo usermod -aG docker $USER
echo "Current mebers of group docker: "
getent group docker

# Note need to log out and log back in for changes to take affect

