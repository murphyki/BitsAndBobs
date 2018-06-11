#!/bin/bash -eux

# See https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Can pass in the specific version of docker or use the default
# which matches kubernetes supported version...
DOCKER_VERSION=${1:-"17.03"}
DOCKER_PACKAGE=${2:-"17.03.2~ce-0~ubuntu-xenial"}

# Load info on th current release, such as DISTRIB_CODENAME, DISTRIB_RELEASE etc
source /etc/lsb-release

# Install prerequisites
source ./setup_prereqs.sh

# Setup docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DISTRIB_CODENAME stable edge"

sudo apt-get update
#sudo apt-get upgrade -y

# Now that the package cache has been updated, identify the package name for
# the given version or fall back on the default.
CACHED_DOCKER_PACKAGE=$(apt-cache madison docker-ce | grep $DOCKER_VERSION | head -1 | awk '{print $3}')
DOCKER_PACKAGE=${CACHED_DOCKER_PACKAGE:-"$DOCKER_PACKAGE"}

# Install docker (Community Edition)
sudo apt-get install -y docker-ce=$DOCKER_PACKAGE

# Add the current user to the docker group
echo "Current user is: $USER"
sudo usermod -aG docker $USER

# Verify that the user was added to the docker group
echo "Current mebers of group docker: "
getent group docker

echo "####################################################################"
echo "# Note:                                                            #"
echo "# To apply the new group membership, you can log out of the server #"
echo "# and back in, or you can type the following: su $USER             #"
echo "####################################################################"
