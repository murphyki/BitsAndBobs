#!/bin/bash -eux

# Setup a k8s master
source ./setup_k8s_master

# Allow pods to be scheuled on the master node, which
# effectively turns this into a single node cluster.
kubectl taint nodes --all node-role.kubernetes.io/master-
