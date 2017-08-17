Vagrant Commands
=============================
Common Vagrant commands
```
vagrant --help
```
```
vagrant --version
```
```
vagrant version (prints current and latest version)
```
```
vagrant status
```
```
vagrant ssh (ssh to the vm)
```
```
vagrant init (generate a new Vagrantfile)
```
```
vagrant box add <box_name>
```
```
vagrant up
```
```
vagrant halt
```
```
vagrant reload
```
```
vagrant suspend
```
```
vagrant resume
```
```
vagrant provision
```
```
vagrant destroy
```
For complete documentation, check out the Vagrant docs: http://docs.vagrantup.com/v2/

In brief, to begin, initalise vagrant with a box. This can be done in a few ways.
The first example is as follows:
```
vagrant init
vagrant box add hashicorp/precise32
vagrant up
```
The second example is as follows:
```
vagrant init hashicorp/precise32
vagrant up
```
For a comprehensive list of boxes see: see https://vagrantcloud.com/

Customise Vagrant by installing plugins
```
vagrant plugin install [plugin_name]
```
Example, if chef-client is to be installed on the vagrant vm, first need to install 
the ```vagrant-omnibus``` plugin:
```
vagrant plugin install vagrant-omnibus
```
Then add the following line to your Vagrantfile:
```
config.omnibus.chef_version = :latest
```
followed by ```vagrant provision``` on a vm that was already started with ```vagrant up``` 
and the chef-client will be installed.

For details on the vagrant-omnibus plugin visit: https://github.com/schisamo/vagrant-omnibus

Build your own development box
===============================
To build your own development box you can use the ```Vagrantfile``` above.

It will create a ```Virtualbox``` virtual machine with a bunch og software pre-installed, such as: git, python, pip, php, java, maven, gradle, sdkman, nvm, node, npm, eclipse, pycharm and more...

To build your own box follow the following steps:

- Copy the ```Vagrantfile``` to your machine
- From that location run:
  ```
  vagrant up
  ```
- Once the VM is ready, customise it as needed. As already mentioned it has a bunch of stuff already installed but you might want to add some more!
- Before creating a box from the vm we eed to do a few things in preparation (see https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one)
  - clean up the VM: 
  ```
  sudo apt-get clean
  ```
  - zero out the drive:
  ```
  sudo dd if=/dev/zero of=/EMPTY bs=1M
  sudo rm -f /EMPTY
  ```
  - clear the history:
  ```
  cat /dev/null > ~/.bash_history && history -c && exit
  ```
  - repackage the vm into a new vagrant box:
  ```
  vagrant package --output mydev.box
  ```
  - finally, add the new box to your vagrant install:
  ```
  vagrant box add mydevbox mydev.box
  ```
- To use the new box, we can initialie a new vagrant file as follows:
  - in a seperate folder, issue the following command:
  ```
  vagrant init mydevbox
  ```
  - now create a new vm using this new ```Vagrantfile```:
    - as before to standup a new vm issue the following command:
    ```
    vagrant up
    ```
