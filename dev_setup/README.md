# Setup Instructions
The instructions below should work for any Debian based version of Linux.

## Base Environment Setup
- First, deploy a VM using VMWare Workstation, it has to be Workstation as it supports nested VMs whereas, unfortunately, VirtualBox does not. We need nested VM capability because minikube is deployed as a VM
- Deploy the VM from the OS ISO file, in my case this was `ubuntu-16.04.4-desktop-amd64.iso` which i downloaded from the ubuntu downloads site. The VM setup is super simple with Workstation. One thing though, check the date and time after installtion is complete, my date and time was way off!!
- Clone this repo: `git clone https://github.com/murphyki/BitsAndBobs.git` 
- Change directory into the repo folder and: `chmod +x *.sh` all the script files
- Execute: `./setup_dev_env.sh`
- Wait until script finishes, it'll take a while, 10/20 minutes
- Give the VM a spin and make sure apps are working as expected
- Power down the VM and edit the VM settings - go to `Processors` and ensure that the checkbox `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked 
- Take a snapshot of the VM, this will be the base snapshot we can rollback to if future endeavours go pear shaped
- Go ahead and install other apps, e.g. kubernetes, IDEs, etc

## Docker Environment Setup
- Change directory to the `BitsAndBobs` repo
- Execute: `./setup_docker.sh`
- Wait until script finishes, it'll take a while, 2/3 minutes
- Log out of the VM and log back in so that docker related changes to groups can take affect
- All going well, take a snapshot of the VM
- Go ahead and install other apps, e.g. Docker, Kubernetes, ansible, AWX, etc

Note:
When building docker images it seems that docker is not always able to reach out to the internet for packages and the build fails.
As a work-around, create the following docker network, using the IP of the host:

`docker network create -o "com.docker.network.bridge.host_binding_ipv4"="10.X.X.X" my-network`

where 10.X.X.X is your host IP

Then when building an image execute:
`docker build --network my-network .`

## Kubernetes Environment Setup
- Change directory to the `BitsAndBobs` repo
- Execute: `./setup_k8s.sh`
- Wait until script finishes, it'll take a while, 5/10 minutes
- All going well, take a snapshot of the VM
- Go ahead and install other apps, e.g. ansible, AWX, etc

N.B. before setting up your kubernetes environment on your VM, ensure you have enabled virtualisation: go to `Processors` and check that the checkbox `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked. We will be installing `minikube` which downloads and launches a VM and if virtualisation is not enabled for the VM this will fail. If this happens, run `minikube delete` and reinstall minikube - see `setup_k8s.sh` for instructions

## Ansible and AWX Setup
- Change directory to the `BitsAndBobs` repo
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
