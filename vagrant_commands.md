Vagrant Commands
=============================
Common Vagrant commands

- vagrant --help
- vagrant init (generate a new Vagrantfile)
- vagrant up
- vagrant halt
- vagrant reload
- vagrant suspend
- vagrant resume
- vagrant provision
- vagrant plugin install <plugin_name>

NOTE:
To install chef-client on a vagrant vm, install the vagrant-omnibus plgin as follows:
  vagrant plugin install vagrant-omnibus

Then add the following line to Vagrantfile:
  config.omnibus.chef_version = :latest

Then run 'vagrant provision' and the chef-client will be installed.
