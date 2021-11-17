#!/bin/bash

USER=$1

# create the user directory if necessary
mkdir -p "/home/$USER"
# first create it if it doesn't exist yet
touch "/home/$USER/.bash_history"
# then change ownership
chown "$USER:$USER /home/$USER/.bash_history"
# and change the permissions
chmod 700 "/home/$USER/.bash_history"
# Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE capability can set or clear this attribute. 
chattr +a "/home/$USER/.bash_history"