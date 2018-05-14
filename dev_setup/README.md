# Setup Instructions
## Base Environment Setup
- First, deploy a VM using VMWare Workstation, it has to be Workstation as it supports nested VMs whereas, unfortunately, VirtualBox does not. We need nested VM capability because minikube is deployed as a VM
- Deploy the VM from the OS ISO file, in my case this was `ubuntu-16.04.4-desktop-amd64.iso` which i downloaded from the ubuntu downloads site. THe VM setup is super simple with Workstation. One thing though, check the date and time after installtion is complete, my date and time was way off!!
- Clone this repo: `git clone https://github.com/murphyki/BitsAndBobs.git` 
- Change directory into the repo folder and: `chmod +x *.sh` all the script files
- Execute: `./dev_env_setup.sh`
- Wait until script finishes, it'll take a while, 10/20 minutes
- You then need to log out of the VM and log back in so that docker related changes to groups take affect
- Give the VM a spin and make sure apps are working as expected
- Power down the VM and edit the VM settings - go to `Processors` and ensure that the checkbox `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked 
- Take a snapshot of the VM, this will be the base snapshot we can rollback to if future endeavours go pear shaped
- Go ahead and install other apps, e.g. kubernetes, IDEs, etc

## Kubernetes Environment Setup

## Ansible and AWX 

