# Setup Instructions
The instructions below work for Ubuntu.
They've been tested on Ubuntu 16.04 and 18.04.
Your mileage with other versions may vary... :)

## Prerequisites
You need a VM, you have the following choices:
1. Use the [packer project](../packer/readme.md) to build your own custom VM.
2. Download an ISO for the version you want to work with and install a VM in [VMware Workstation](https://www.vmware.com/products/workstation). The VM setup is super simple with Workstation. One thing though, check the date and time after installation is complete, my date and time was way off!!

Note:
- If you intend to use `minikube` as your kubernetes environment then you need to
ensure that your virtualization application supports nested virtualization because minikube itself runs as a VM and the VM you create must nave nested virtualization enabled. This is another reason to chose VMWare Workstation as it supports nested VMs whereas, unfortunately, VirtualBox does not
- The packer builds enable VM virtualization by default, but if you go the ISO route you can enable nested virtualization as follows: go to `Processors` and ensure that the checkbox `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked

## Base Environment Setup
Once you have a VM created and powered on do the following from your console of choice:
- Ensure git is installed:
      $ sudo apt-get install -y git
- Clone this repo:
      $ git clone https://github.com/murphyki/BitsAndBobs.git
- Change directory into this repo folder and run:
      $ chmod +x *.sh
- Execute:
      $ ./setup_dev_env.sh
- Wait until script finishes, it'll take a while, 10/20 minutes
- Give the VM a spin and make sure apps are working as expected
- Power down the VM and edit the VM settings and check that you have nested virtualization enabled:  go to `Processors` and ensure that the checkbox `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked
- Take a snapshot of the VM, this will be the base snapshot we can rollback to if future endeavours go pear shaped
- Go ahead and install other apps, e.g. docker, ansible AWX, kubernetes, IDEs, etc

## Docker Environment Setup
- Change directory to the `BitsAndBobs/dev_setup` repo
- Execute: `./setup_docker.sh`
  - If using ubuntu 18.04 issue the following command instead: `./setup_docker.sh 18.05`
  - This is because docker 17.03 is not yet available on ubuntu 18.04
- Wait until script finishes, it'll take a while, 2/3 minutes
- Log out of the VM and log back in so that docker related changes to groups can take affect
- All going well, take a snapshot of the VM
- Go ahead and install other apps, e.g. Docker, Kubernetes, ansible, AWX, etc

Note:
- When building docker images it seems that docker is not always able to reach out to the internet for packages and the build fails.
- As a work-around, use the `host` docker network: `docker build --network host .`

## Kubernetes Environment Setup
For a kubernetes environment you have choices:
1. Istall and use [minikube](https://github.com/kubernetes/minikube)  
2. Install a single node cluster using [kubeadm](https://kubernetes.io/docs/tasks/tools/install-kubeadm/)

Note: Favour a single node luster over minikube as it gives much better performance and is not as resource hungry.

### Minikube Setup
- Change directory to the `BitsAndBobs/dev_setup` repo
- Execute: `./setup_k8s_minikube.sh`
- Wait until script finishes, it'll take a while, 5/10 minutes
- All going well, take a snapshot of the VM
- Go ahead and install other apps, e.g. ansible, AWX, etc

Note:
- Before setting up your minikube kubernetes environment on your VM, ensure you have enabled virtualisation: go to `Processors` and check that the checkbox `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked. We will be installing `minikube` which downloads and launches a VM and if virtualisation is not enabled for the VM this will fail. If this happens, run `minikube delete` and reinstall minikube - see `setup_k8s.sh` for instructions
- When building docker images to run as containers in minikube, there is a little gotcha: the images you build on your vm are not visible inside the minikube VM, so when you try to deploy pods based on your docker images the pods will fail to run with an error:
```
Container image "murphyki/web-gateway" is not present with pull policy of Never
Error: ErrImageNeverPull
```
- To work around this run the following command inside the shell window you are currently working in so that it uses the minikube docker:
```
eval $(minikube docker-env)
```
To see the affect of this run: `docker images` notice how your docker images are not there...
- You now need to rebuild all your docker images again so that they are available inside the minikube VM

### Single Node Cluster Setup
- Change directory to the `BitsAndBobs/dev_setup` repo
- Execute: `./setup_k8s_single_node_cluster.sh`
  - Note the join token from the output in case we want to add some worker nodes later, but right now our master node will also act as a worker node...
- Wait until script finishes, it'll take a few mins, 2/3 minutes
- Deploy the kubernetes dashboard:  `./setup_k8s_dashboard.sh`
  - Note the token dumped to the console, we can use that when asked to login to the dashboard later
- All going well, take a snapshot of the VM
- Go ahead and install other apps, e.g. ansible, AWX, etc


## Ansible and AWX Setup
- Change directory to the `BitsAndBobs/dev_setup` repo
- Execute: `./setup_ansible_awx.sh`
- Wait until script finishes, it'll take a while, 4/5 minutes
- At this point we have ansibe installed and the AWX github repo cloned _but_ to complete the AWX setup we need to edit some of the setings in the `awx/inventory` file
- To complete the AWX setup, do the following:
  - `cd awx/installer`
  - Edit the config in the `inventory` file:
    - change the `docker_port` from `80` to `8080`
    - change the default username and password
  - Execute: `ansible-playbook -i inventory install.yml`
- All going well, take a snapshot of the VM
