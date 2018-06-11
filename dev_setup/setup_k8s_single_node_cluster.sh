#!/bin/bash -eux

# Setup a k8s master
source ./setup_k8s_master.sh

# Allow pods to be scheuled on the master node, which
# effectively turns this into a single node cluster.
# See https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
kubectl taint nodes --all node-role.kubernetes.io/master-
