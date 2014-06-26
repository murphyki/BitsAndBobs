Vagrant Commands
=============================
Common Vagrant commands
```
vagrant --help
vagrant --version
vagrant version (prints current and latest version)
vagrant status
vagrant ssh (ssh to the vm)
vagrant init (generate a new Vagrantfile)
vagrant up
vagrant halt
vagrant reload
vagrant suspend
vagrant resume
vagrant provision
vagrant destroy
```
Check out the Vagrant docs for more: http://docs.vagrantup.com/v2/

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
