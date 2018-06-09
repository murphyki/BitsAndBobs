#!/bin/bash -eux

# Install prerequisites
./setup_prereqs

# Install docker, rancher explicitly supports certain version so
# install one of the, see:
# https://rancher.com/docs/rancher/v2.x/en/quick-start-guide/
# https://github.com/rancher/rke/wiki/Quick-Start-Guide
# NOTE: You may need to run this script in 2 stages if installing on a clean vm
# since after installing docker and updating the docker group you need to
# log out of the VM and log back in for the changes to take affect.
curl https://releases.rancher.com/install-docker/17.03.sh | sh
sudo usermod -aG docker $USER

# Open ports
# See https://rancher.com/docs/rancher/v2.x/en/installation/single-node-install/
sudo iptables -A INPUT -p tcp --dport 6443 -j ACCEPT
sudo iptables -A INPUT -p tcp --match multiport --dports 2379:2380 -j ACCEPT
sudo iptables -A INPUT -p tcp --match multiport --dports 10250:10256 -j ACCEPT
sudo iptables -A INPUT -p tcp --match multiport --dports 30000:32767 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 8472 -j ACCEPT
sudo iptables-save

# Install rancher
sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:latest
