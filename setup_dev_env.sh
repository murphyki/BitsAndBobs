#!/bin/bash -eux

# Notes:
# 1. First, deploy a VM using VMWare Workstation, it has to be Workstation as it supports
# nested VMs whereas, unfortunately, VirtualBox does not. We need nested VM capability
# because minikube is deployed as a VM
# 2. Deploy the VM from the OS ISO file, in my case this was ubuntu-16.04.4-desktop-amd64.iso
# which i downloaded from the ubuntu downloads site. THe VM setup is super simple with Workstation
# One thing though, check the date and time after installtion is complete, mine date and time were way off!!
# 3. Clone this repo, change directory into the repo folder and: chmod +x dev_env_setup.sh
# 4. Execute: ./dev_env_setup.sh
# 5. Wait until script finishes, it'll take a while, 10/20 minutes
# 6. You then need to log out of the VM and log back in so that docker related changes to groups take affect
# 7. Give the VM a spin and make sure apps are working as expected
# 8. Power down the VM and edit the VM settings - go to Processors and ensure that the checkbox
# `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked 
# 9. Take a snapshot of the VM, this will be the base snapshot we can rollback to if future
# endeavours go pear shaped
# 10. Go ahead and install other apps, e.g. kubernetes, IDEs, etc

# Install core apps
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Setup keys and repos
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/atom
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3

sudo add-apt-repository "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get upgrade -y

# Install java8
sudo echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
sudo echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer # or sudo apt-get install oracle-java9-installer

curl -O https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_x86_64.deb
curl -O https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_SHA256SUMS
curl -O https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_SHA256SUMS.sig
curl -sS https://keybase.io/hashicorp/key.asc | gpg --import
gpg --verify vagrant_2.0.2_SHA256SUMS.sig vagrant_2.0.2_SHA256SUMS
shasum -a 256 -c <(cat vagrant_2.0.2_SHA256SUMS | grep 64.deb) -s

# Install apps
sudo apt-get install -y python python-dev python-setuptools build-essential
sudo apt-get install -y python-pip # or easy_install pip
sudo apt-get install -y php libapache2-mod-php php-cli
sudo apt-get install -y terminator
sudo apt-get install -y filezilla
sudo apt-get install -y atom sublime-text-installer
sudo apt-get install -y virtualbox-5.2 ./vagrant_2.0.2_x86_64.deb

sudo apt-get install -y docker-ce
echo "Current user is: $USER"
sudo usermod -aG docker $USER
echo "Current mebers of group docker: "
getent group docker
# Note need to log out and log back in for changes to take affect


