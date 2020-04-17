#!/bin/bash -eux

# See https://istio.io/docs/setup/kubernetes/quick-start/#download-and-prepare-for-the-installation

WORKDIR=~/Development
ISTIO_VERSION=${1:-"0.8.0"}
ISTIO_BASEDIR="$WORKDIR/istio-$ISTIO_VERSION"
ISTIO_BINDIR="$ISTIO_BASEDIR/bin"

if [ ! -d "$WORKDIR" ]; then
    mkdir $WORKDIR
fi

if [ -d "$ISTIO_BASEDIR" ]; then
    rm -rf $ISTIO_BASEDIR
fi

cd $WORKDIR

# Install istio
echo "Installing istio $ISTIO_VERSION to $WORKDIR"
curl -L https://git.io/getLatestIstio | sh -

export PATH=$ISTIO_BINDIR:$PATH

echo "Installing istio into kubernetes cluster"
kubectl apply -f $ISTIO_BASEDIR/install/kubernetes/istio-demo-auth.yaml
