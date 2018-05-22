#!/bin/bash -eux

WORKDIR=~/Development/repositories

if [ ! -d "$WORKDIR" ]; then
    mkdir -p $WORKDIR
fi

cd $WORKDIR

# Clone some sample repos for playing with kubernetes and ansible
if [ ! -d "ngci-demo" ]; then
    git clone https://github.com/silvam11/ngci-demo.git
fi

if [ ! -d "kfd-flask" ]; then
    git clone https://github.com/kubernetes-for-developers/kfd-flask.git
fi

if [ ! -d "kfd-nodejs" ]; then
    git clone https://github.com/kubernetes-for-developers/kfd-nodejs.git
fi

if [ ! -d "kfd-celery" ]; then
    git clone https://github.com/kubernetes-for-developers/kfd-celery.git
fi

if [ ! -d "masteringansible" ]; then
    git clone https://github.com/spurin/masteringansible.git
fi

# Use minikubes docker
eval $(minikube docker-env)

# Deploy k8s examples
pushd .
cd ./kfd-flask
docker build -t kubernetes-for-developers/flask .
if ! kubectl get deployment flask; then
    kubectl run flask --image=kubernetes-for-developers/flask --port=5000 --overrides='{"spec":{"template":{"spec":{"containers":[{"name":"flask","imagePullPolicy":"Never","image":"kubernetes-for-developers/flask"}]}}}}'
fi
popd

pushd .
cd ./kfd-nodejs
docker build -t kubernetes-for-developers/nodejs .
if ! kubectl get deployment nodejs; then
    kubectl run nodejs --image=kubernetes-for-developers/nodejs --port=3000 --overrides='{"spec":{"template":{"spec":{"containers":[{"name":"nodejs","imagePullPolicy":"Never","image":"kubernetes-for-developers/nodejs"}]}}}}'
fi
popd
