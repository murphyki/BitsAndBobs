#!/bin/sh

# Interactive script to configure passwordless ssh login
# on a remote machine

key=~/.ssh/id_rsa
remote_user=
remote_ip=
 
if [ ! -f "$key" ]
then
    echo "No ssh public key found. Generating one now..."
    echo -e 'y/n' | ssh-keygen -t rsa -f $key -P ""
fi

echo "Copying key to remote machine..."
ssh-copy-id -i $key.pub $remote_user@$remote_ip
