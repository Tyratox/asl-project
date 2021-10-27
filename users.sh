#!/bin/bash

# change home directory from 755 to 700 for new users
sed -i 's/DIR_MODE=0755/DIR_MODE=0700/' /etc/adduser.conf

# timeoutd to log out users after some idle time