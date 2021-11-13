# Installation

## Operating System

1. Download the newest image, for example [debian-11.1.0-amd64-netinst.iso](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso) in case of x64 Debian.
2. Create a new VM and choose the just downloaded ISO as installation medium
3. When promted, set the hostname to `hostname` and leave the domain empty
4. When setting up a server VM
   1. Partition the file system in a way s.t. the folders containing the temporary files are on different partitions (`/tmp` and `/var/tmp`)
   2. Certain folders can also be put on a different partition, for example folders containing static information. These partitions can then be mounted read-only.
   3. In the software selection menu, select `standard system utilities` and `SSH server`
5. When setting up a client
   1. It suffices to just put everything on one partition
   2. In the software selection menu, select `Debian Desktop Environment`, `GNOME` and `standard system utilities`.
6. For installation allow the VMs to connect to the internet by setting the Network mode to for example NAT.

## Filesystem

## Software

The easiest way to run the scripts in this folder is the following:

1. Run `su` and authenticate as root using your password
2. Install git by running `apt-get install git`
3. Download the scripts hosted in this repository by running `git clone`
4. Create a snapshot of the VM
5. Change the working directory by running `cd asl-project`
6. Run the setup script for the respective machine / VM e.g. `./setup/certificate-authority.sh`
   1. In case of `certificate-authority.sh`, the following arguments are required:
      1. The first argument is the IP of the host machine in order download the unencrypted private key. This will probably change in the near future.
