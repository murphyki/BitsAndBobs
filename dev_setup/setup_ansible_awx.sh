#!/bin/bash -eux

# Install prerequiites
sudo apt-get install -y bzip2 zip unzip build-essential

# Add repos
sudo apt-add-repository -y ppa:ansible/ansible

sudo apt-get update

# Install ansible
sudo apt-get install -y ansible

# Install nvm to manage nodejs
# See: https://github.com/creationix/nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
. ~/.nvm/nvm.sh
nvm install --lts node
npm install --global npm@latest

pip install docker-py --user

# Install AWX
git clone https://github.com/ansible/awx.git
# To continue the AWX installation do the following:
# 1. cd awx/installer
# 2. Edit the config in the inventory file, change the docker port from 80 to 8080
# 3. ansible-playbook -i inventory install.yml
