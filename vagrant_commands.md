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
