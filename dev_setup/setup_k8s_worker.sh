#!/bin/bash -eux

# Install prerequisites
source ./setup_prereqs

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo touch /etc/apt/sources.list.d/kubernetes.list
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Swap must be turned off
sudo swapoff -a

# Install kubernetes
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

# Setup kubernetes config - must be done as a normal user...
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config | tee -a ~/.bashrc

# If all went well can join a k8s cluster with a command like the following:
#sudo kubeadm join 192.168.217.145:6443 --token uwtldh.147n0kr1t5cr8ujk --discovery-token-ca-cert-hash sha256:941c83742e2a9db1151e268aaa10f448ea40d9ec93ed581d1f1031fca0642b51
