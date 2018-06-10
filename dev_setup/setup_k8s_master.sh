#!/bin/bash -eux

# Initialise the kubernetes master
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Setup kubernetes config - must be done as a normal user...
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config | tee -a ~/.bashrc

# Deploy a pod network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml

# Check that the pod network has been deployed
kubectl get pods --all-namespaces
