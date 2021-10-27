#!/bin/bash

# install binaries related to security or access control
apt-get install sudo

# user configurations
./users.sh

# configure PAM
./pam.sh

# configure logging
./auditing.sh

# SELinux
./selinux/index.sh