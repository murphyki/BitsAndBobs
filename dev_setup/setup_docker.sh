#!/bin/bash -eux

# Can pass in the specific version of docker or use the default
# which matches kubernetes supported version...
DOCKER_VERSION=${1:-"17.03"}
DOCKER_PACKAGE=${2:-$(apt-cache madison docker-ce | grep $DOCKER_VERSION | head -1 | awk '{print $3}')}
DOCKER_PACKAGE=${DOCKER_PACKAGE:-"17.03.2~ce-0~ubuntu-xenial"}

LINUX_CODENAME=$(lsb_release -cs)

echo "Installing docker version $DOCKER_VERSION using package $DOCKER_PACKAGE"

# Install prerequisites
source ./setup_prereqs.sh

# Setup docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $LINUX_CODENAME stable"

sudo apt-get update
#sudo apt-get upgrade -y

# Install docker (Community Edition)
sudo apt-get install -y docker-ce=$DOCKER_PACKAGE

# Add the current user to the docker group
echo "Current user is: $USER"
sudo usermod -aG docker $USER

# Verify that the user was added to the docker group
echo "Current mebers of group docker: "
getent group docker

# Note need to log out and log back in for changes to take affect
