#!/bin/bash -eux

# See: https://kubernetes.io/docs/tasks/tools/install-minikube/
# See: https://kubernetes.io/docs/tasks/tools/install-kubectl/
sudo snap list
sudo snap find kubectl
sudo snap install kubectl --classic
kubectl version

# See: https://github.com/kubernetes/minikube/releases
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.26.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
# Note:
# 1. had to add -k to the curl command above die to certificate errors, which is not ideal...
# 2. Downloading the minikube ISO from behind a corporate firewall may not work, so
# you need to use an open connection...
minikube version
minikube start

# Test out the setup
kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080

kubectl expose deployment hello-minikube --type=NodePort

kubectl get pod

curl $(minikube service hello-minikube --url)

kubectl delete deployment hello-minikube

minikube stop
