# Overview
[Previously](kubernetes_env_setup_OLD.md) I used [minikube](https://minikube.sigs.k8s.io/docs/) to setup a local dev enviromment for kubernetes. 
TBH, I never really liked minikube cos it seemed very cumbersome to use and seemed heavy on my system resources (crap laptop didn't help!), but at the time it was the recommended way of getting started.

That was almost 2 years ago now, and man have things changed since then!

# Alternatives
Below I list some alternatives to minikube that I have been experimenting with, there are [others](https://kubernetes.io/docs/tasks/tools/), but these are the ones I am most familar with.

## microk8s
[microk8s](https://microk8s.io/) was my favourite (see later) for a long time as it is extremely simple and quick to set up if you run a ubuntu system or VM. 
It comes with many [addons](https://microk8s.io/docs/addons) out of the box such as [istio](https://istio.io/), [prometheus](https://prometheus.io/), [jaeger](https://www.jaegertracing.io/), [fluentd](https://www.fluentd.org/), [elastic](https://www.elastic.co/) and [kibana](https://www.elastic.co/kibana) just to name a few.

For a long while this was my go-to kubernetes environment setup.

## k3s
to do...


## k3d
to do...

# Resources
https://codeburst.io/creating-a-local-development-kubernetes-cluster-with-k3s-and-traefik-proxy-7a5033cb1c2d
to do...
