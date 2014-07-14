Chef Commands
=============================
Common Chef commands
```
knife --help
knife --version
knife client list
knife node list
knife node show NODE
```
Configure knife to talk to chef server
```
knife configure --initial
```
Download and use a cookbook from the community site http://community.opscode.com/
```
tar -xzvf COOKBOOK_NAME.tar.gz -C cookbooks
knife cookbook site download COOKBOOK_NAME
```
Upload a cookbook to the Chef server
```
knife cookbook upload COOKBOOK_NAME
```
Edit node properties
```
knife node edit NODE
```
NOTE: ensure EDITOR environment variable is set: ```export EDITOR=vim```
knife uses the ```$EDITOR``` variable for loading an editor program

Create a new cookbook
```
knife cookbook create COOKBOOK_NAME
```

Create a new role
```
knife role create ROLE_NAME
```
NOTE: roles are stored as JSON files under the roles folder
Can also create roles from a JSON file
```
knife role from file FILE_NAME
```
