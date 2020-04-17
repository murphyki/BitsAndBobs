#!/bin/bash -eux

# See https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Can pass in the specific version of docker or use the default
# which matches kubernetes supported version...
DOCKER_VERSION=${1:-"19.03"}
DOCKER_PACKAGE=${2:-"5:19.03.8~3-0~ubuntu-bionic"}

# Load info on the current release, such as DISTRIB_CODENAME, DISTRIB_RELEASE etc
source /etc/lsb-release

# Install prerequisites
source ./setup_prereqs.sh

# Remove older versions of docker
sudo apt-get remove docker docker-engine docker.io containerd runc

# Setup docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${DISTRIB_CODENAME} stable"

# Now that the package cache has been updated, identify the package name for
# the given version or fall back on the default.
sudo apt-get update
CACHED_DOCKER_PACKAGE=$(apt-cache madison docker-ce | grep ${DOCKER_VERSION} | head -1 | awk '{print $3}')
DOCKER_PACKAGE=${CACHED_DOCKER_PACKAGE:-"$DOCKER_PACKAGE"}

# Install docker (Community Edition)
sudo apt-get install -y docker-ce=${DOCKER_PACKAGE} docker-ce-cli=${DOCKER_PACKAGE} containerd.io

# Add the current user to the docker group
echo "Current user is: ${USER}"
sudo usermod -aG docker ${USER}
newgrp docker

# Verify that the user was added to the docker group
echo "Current mebers of group docker: "
getent group docker

# Verify that Docker Engine is installed correctly by running the hello-world image
docker run hello-world
