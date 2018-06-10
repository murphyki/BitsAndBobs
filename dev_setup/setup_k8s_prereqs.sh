#!/bin/bash -eux

# Install prerequisites
source ./setup_prereqs

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo touch /etc/apt/sources.list.d/kubernetes.list
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Swap must be turned off
sudo swapoff -a

# Make this permnent since when we reboot swap will be turned back on
# and kubectl will fail to start.
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Ensure we can pass bridged IPv4 traffic to iptables’ chains.
# This is a requirement for some CNI plugins to work.
sudo touch /proc/sys/net/bridge/bridge-nf-call-iptables
echo "1" | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables

# Install kubernetes
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
