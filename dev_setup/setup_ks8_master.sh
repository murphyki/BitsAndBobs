#!/bin/bash -eux

# Install prerequisites
./setup_prereqs

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

sudo cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Install kubernetes
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

# Initialise the kubernetes master
sudo kubeadm init

# Setup kubernetes config - must be done as a normal user...
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config | tee -a ~/.bashrc

# Deploy a pod network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

# Check that the pod network has been deployed
kubectl get pods —all-namespaces
