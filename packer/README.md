# Packer templates for Ubuntu and CentOS

### Overview

This folder contains Packer templates for creating:
- Ubuntu
- CentOS
- CentOS Atomic

OVAs and boxes for VMWare and VirtualBox.

## Prerequisites
Ensure you have the following software installed:
- [packer](https://www.packer.io/)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [VMware Workstation](https://www.vmware.com/products/workstation) or for amc users, [VMware Fusion](https://www.vmware.com/products/fusion)
- [VMWare ovftool](https://www.vmware.com/support/developer/ovf/)

NOTE:
- If building on Windows, run your console in administrator mode 
- Ensure that both the `packer` and `ovftool` executables are available on your `PATH`.

## Building with Packer
The provided templates can be customized via user variables defined in JSON files.
You tell `packer` to use a specific user variable file via the `-var-file=` command line
option. This will override the default values within the given packer template.

For example, to build Ubuntu 16.04 server, use the following:

    $ packer build -var-file=ubuntu1604-server.json ubuntu.json

NOTE: This will build VMs for _all_ supported desktop virtualization platforms.

If you want to make VMs for a specific desktop virtualization platform, use the `-only`
parameter.  For example, to build Ubuntu 16.04 server for VMWare:

    $ packer build -only=vmware-iso -var-file=ubuntu1604-server.json ubuntu.json

Alternatively, to build Ubuntu 16.04 server for VirtualBox

    $ packer build -only=virtualbox-iso -var-file=centos7.json centos.json

The provided templates currently support the following desktop virtualization strings:

- `virtualbox-iso` - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) desktop virtualization
- `vmware-iso` - [VMware Fusion](https://www.vmware.com/products/fusion) or [VMware Workstation](https://www.vmware.com/products/workstation) desktop virtualization

## Troubleshooting
For information on debugging issues with packer see [Debugging Packer Builds](https://www.packer.io/docs/other/debugging.html).

For the impatient, here are some quick tips:
- To inspect failures, use `-on-error=ask` commandline option to `packer`:
  - `$ packer build -on-error=ask template.json`
- To turn on detailed debugging and logs before running `packer` builds:
  - set PACKER_LOG=1 && set PACKER_LOG_PATH="packerlog.txt"
