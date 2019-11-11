#!/bin/bash -eux

sudo apt-get update

# Install base tools
sudo apt-get install -y apt-transport-https 
sudo apt-get install -y ca-certificates 
sudo apt-get install -y curl
sudo apt-get install -y software-properties-common
sudo apt-get install -y bzip2 zip unzip 
sudo apt-get install -y build-essential 
sudo apt-get install -y git

# Install Python
sudo apt-get install -y python python-dev python-setuptools
sudo apt-get install -y python-pip # or easy_install pip
#pip install --upgrade pip
pip install virtualenv

# Install nvm to manage nodejs
# See: https://github.com/creationix/nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.nvm/nvm.sh

# Install Node and NPM
nvm install --lts node
npm install --global npm@latest

# Install PHP
if [ -z `which php` ]
then
    sudo apt-get install -y php
    sudo apt-get install -y libapache2-mod-php
    sudo apt-get install -y php-cli
    sudo apt-get install -y php-zip
    sudo apt-get install -y php-mbstring
    sudo apt-get install -y php-gd
    sudo apt-get install -y php-xml
else
    echo "php already installed"
fi

if [ -z `which composer` ]
then
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    rm composer-setup.php

    sudo mv composer.phar /usr/local/bin/composer

    # Install laravel
    composer global require laravel/installer
else
    echo "composer already installed"
fi

# Install SDKMAN
curl -s "https://get.sdkman.io" | bash
source ~/.bashrc

# Install Maven and Java
#sdk install maven
#sdk install java 8.0.192-zulu

# Install tools
sudo apt-get install -y terminator
sudo apt-get install -y filezilla
sudo snap install atom --classic
sudo snap install code --classic
sudo snap install postman --classic
sudo snap install pycharm-community --classic
