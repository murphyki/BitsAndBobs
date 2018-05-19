#!/bin/bash -eux

WORKDIR=~/Development/repositories

mkdir -p $WORKDIR
cd $WORKDIR

# Clone some sample repos for playing with kubernetes
git clone https://github.com/silvam11/ngci-demo.git
git clone https://github.com/kubernetes-for-developers/kfd-flask.git
git clone https://github.com/kubernetes-for-developers/kfd-nodejs.git
git clone https://github.com/kubernetes-for-developers/kfd-celery.git
git clone https://github.com/spurin/masteringansible.git
