# Overview
Some handy commands for setting up a dev instance of kubernetes.

## kubectl Installation
### Linux
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```

### MacOS 
``` 
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl
```

### Windows 
``` 
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/windows/amd64/kubectl.exe
```

### Setup
```
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version
```

## minikube Installation
### Linux 
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.23.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

### macOS 
``` 
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.23.0/minikube-darwin-amd64 && chmod +x 
```

### Setup
```
minikube && sudo mv minikube /usr/local/bin/
minikube start
kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080
kubectl expose deployment hello-minikube  --type=NodePort
kubectl get pod
curl $(minikube service hello-minikube --url)
kubectl delete deployment hello-minikube
minikube stop
```

## Trouble Shooting
### Error 1
```
[root@larry ~]# minikube start
Starting local Kubernetes v1.10.0 cluster...
Starting VM...
E0726 16:03:16.856132 3753 start.go:168] Error starting host: Error creating host: Error executing step: Running precreate checks.
: This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory.
 
Retrying.
E0726 16:03:16.856723 3753 start.go:174] Error starting host: Error creating host: Error executing step: Running precreate checks.
: This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory
```
### Solution
Run minikube start --vm-driver=none instead

### Error 2
```
root@localhost ~]# minikube start
Starting local Kubernetes v1.10.0 cluster...
Starting VM...
E0504 17:44:35.629203    9741 start.go:159] Error starting host: Error creating host: Error executing step: Running precreate checks.
: VBoxManage not found. Make sure VirtualBox is installed and VBoxManage is in the path.
 Retrying.
E0504 17:44:35.630354    9741 start.go:165] Error starting host:  Error creating host: Error executing step: Running precreate checks.
: VBoxManage not found. Make sure VirtualBox is installed and VBoxManage is in the path
```

### Solution
On Linux machines you do not need to use any VM Driver.
Run below command instead.
```
./minikube start --vm-driver=none
```
If you are not running Linux machines, Install VirtualBox on the VM.

## Sone kubectl Commands
```
kubectl get pods
kubectl get pods [pod name]
 
kubectl expose <type name> <identifier/name> [—port=external port] [—target-port=container-port [—type=service-type]
kubectl expose deployment tomcat-deployment --type=NodePort
 
kubectl port-forward <pod name> [LOCAL_PORT:]REMOTE_PORT]
 
kubectl attach <pod name> -c <container>
 
kubectl exec  [-it] <pod name> [-c CONTAINER] — COMMAND [args…]
kubectl exec -it <pod name> bash
 
kubectl label [—overwrite] <type> KEY_1=VAL_1 ….
kubectl label pods <pod name> healthy=fasle
 
kubectl run <name> —image=image
kubectl run hazelcast --image=hazelcast/hazelcast --port=5701
# the hazelcast docker image has been moved to hazelcast/hazelcast (https://hub.docker.com/r/hazelcast/hazelcast
 
kubectl describe pod

kubectl scale --replicas=4 deployment/tomcat-deployment 
 
kubectl expose deployment tomcat-deployment --type=NodePort
kubectl expose deployment tomcat-deployment --type=LoadBalancer --port=8080 --target-port=8080 --name tomcat-load-balancer
 
kubectl describe services tomcat-load-balancer

kubectl get deployments
kubectl rollout status
kubectl set image
kubectl rollout history
```
