#!/bin/sh

if [ -z `which php` ]
then
    sudo apt-get update
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
    composer global require laravel/installer
else
    echo "composer already installed"
fi
