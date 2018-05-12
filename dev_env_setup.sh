#!/bin/bash -eux

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
echo "Current user is $USER"
usermod -aG docker $USER
