# -*- mode: ruby -*-
# vi: set ft=ruby :
 
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
 
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "base"
  config.vm.box = "boxcutter/ubuntu1604-desktop"#"hashicorp/precise64" #"centos/7"
 
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
 
     # Customize the amount of memory on the VM:
     vb.memory = "6144"
 
     # Name the vm
     vb.name = "my_dev_vm"
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
 
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    add-apt-repository ppa:webupd8team/java
    add-apt-repository ppa:webupd8team/atom
    add-apt-repository ppa:webupd8team/sublime-text-3
    apt-get update
 
    echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
    apt-get install -y oracle-java8-installer
 
    # note: git and python already installed on base box...
    apt-get install -y python-pip
    apt-get install -y terminator
    apt-get install -y filezilla
    apt-get install -y atom
    apt-get install -y sublime-text-installer
    apt-get install -y php
    apt-get install -y libapache2-mod-php
    apt-get install -y php-cli
 
    if [ ! -d "/opt/idea-IU-172.3544.35" ]; then
      wget -O /opt/ideaIU-2017.2.1-no-jdk.tar.gz https://download.jetbrains.com/idea/ideaIU-2017.2.1-no-jdk.tar.gz
      cd /opt && tar -zxvf ideaIU-2017.2.1-no-jdk.tar.gz
      rm -f ideaIU-2017.2.1-no-jdk.tar.gz
      echo 'export PATH=/opt/idea-IU-172.3544.35/bin:$PATH' >> /home/vagrant/.bashrc
    fi
 
    if [ ! -d "/opt/pycharm-community-2017.2.1" ]; then
      wget -O /opt/pycharm-community-2017.2.1.tar.gz https://download.jetbrains.com/python/pycharm-community-2017.2.1.tar.gz
      cd /opt && tar -zxvf pycharm-community-2017.2.1.tar.gz
      rm -f pycharm-community-2017.2.1.tar.gz
      echo 'export PATH=/opt/pycharm-community-2017.2.1/bin:$PATH' >> /home/vagrant/.bashrc
    fi
 
    if [ ! -d "/opt/eclipse" ]; then
      wget -O /opt/eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz
      cd /opt && tar -zxvf eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz
      rm -f eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz
      echo 'export PATH=/opt/eclipse:$PATH' >> /home/vagrant/.bashrc
    fi
  SHELL
 
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    curl -s https://get.sdkman.io | bash
    source ~/.sdkman/bin/sdkman-init.sh
    #sdk install java - prefer packaged installed version of java...
    sdk install maven
    sdk install gradle
 
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
    . ~/.nvm/nvm.sh
    nvm install --lts node
    npm install --global npm@latest
    #npm install --global bower
    #npm install --global grunt-cli
    #npm install --global @angular/cli
  SHELL
end
