#!/bin/bash -eux

# See https://kubernetes.io/docs/tasks/tools/install-kubeadm/

# Install k8s prerequisites
source ./setup_k8s_prereqs

# Initialise the kubernetes master
# The --pod-network-cidr value is specific to the pod network we want to deploy.
# Here we are using the pod network for flannel, which we deploy below...
# See https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
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
