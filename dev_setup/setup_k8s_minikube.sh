#!/bin/bash -eux

# Provide specific minikube version or use default
MINIKUBE_VERSION=${1:-"0.26.1"}

echo "Installing minikube version $MINIKUBE_VERSION"

# Install prerequisites
source ./setup_prereqs.sh

# See: https://kubernetes.io/docs/tasks/tools/install-minikube/
# See: https://kubernetes.io/docs/tasks/tools/install-kubectl/
sudo snap list
sudo snap find kubectl
sudo snap install kubectl --classic

# See: https://github.com/kubernetes/minikube/releases
# Note: Downloading the minikube ISO from behind a corporate firewall may not work, so you need to use an open connection...
wget -O minikube https://storage.googleapis.com/minikube/releases/v${MINIKUBE_VERSION}/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

minikube start

kubectl version
minikube version

# Test out the setup
kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080

kubectl expose deployment hello-minikube --type=NodePort

kubectl get pod

curl $(minikube service hello-minikube --url)

kubectl delete deployment hello-minikube

minikube stop
