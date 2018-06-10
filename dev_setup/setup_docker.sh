#!/bin/bash -eux

# Calling out a specific version of docker here as kubernetes
# supports certain versions...
DOCKER_VERSION="17.03"

# Install prerequisites
source ./setup_prereqs

# Setup docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

sudo apt-get update
#sudo apt-get upgrade -y

# Install docker (Community Edition)
sudo apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep $DOCKER_VERSION | head -1 | awk '{print $3}')

# Add the current user to the docker group
echo "Current user is: $USER"
sudo usermod -aG docker $USER

# Verify that the user was added to the docker group
echo "Current mebers of group docker: "
getent group docker

# Note need to log out and log back in for changes to take affect
