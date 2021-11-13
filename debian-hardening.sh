#!/bin/bash

TYPE=$1

# install binaries related to security or access control
apt -y install sudo

# user configurations
./users.sh

# configure PAM
./pam.sh

# configure SSH
./ssh.sh

# networking
./networking.sh $TYPE

# configure logging
./auditing.sh

# SELinux
./selinux/index.sh