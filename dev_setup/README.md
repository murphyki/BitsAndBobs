# Setup Instructions
1. First, deploy a VM using VMWare Workstation, it has to be Workstation as it supports nested VMs whereas, unfortunately, VirtualBox does not. We need nested VM capability because minikube is deployed as a VM
2. Deploy the VM from the OS ISO file, in my case this was ubuntu-16.04.4-desktop-amd64.iso which i downloaded from the ubuntu downloads site. THe VM setup is super simple with Workstation. One thing though, check the date and time after installtion is complete, mine date and time were way off!!
3. Clone this repo, change directory into the repo folder and: chmod +x dev_env_setup.sh
4. Execute: ./dev_env_setup.sh
5. Wait until script finishes, it'll take a while, 10/20 minutes
6. You then need to log out of the VM and log back in so that docker related changes to groups take affect
7. Give the VM a spin and make sure apps are working as expected
8. Power down the VM and edit the VM settings - go to Processors and ensure that the checkbox `Virtualize Intel VT-x/EPT or AMD-v/RVI` is ticked 
9. Take a snapshot of the VM, this will be the base snapshot we can rollback to if future endeavours go pear shaped
10. Go ahead and install other apps, e.g. kubernetes, IDEs, etc
