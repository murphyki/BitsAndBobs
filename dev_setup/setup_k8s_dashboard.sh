#!/bin/bash -eux

# See https://github.com/kubernetes/dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# See https://github.com/kubernetes/dashboard/wiki/Creating-sample-user
kubectl create -f service-account.yaml
kubectl create -f cluster-role-binding.yaml

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

echo "Now you can access the dashboard as follows:"
echo "First, create a secure channel to your Kubernetes cluster by running the following command:"
echo "    $ kubectl proxy"
echo "Then access the dashboard in your browser using the following url:"
echo "http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"
echo "When asked to sign in use the token output above."
