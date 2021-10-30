#!/bin/bash

mkdir /home/administrator/.ssh
# create new file with authorized keys
cat ./public-keys/administrator-key.pub > /home/administrator/.ssh/authorized_keys

# disable password authentication
sed -i 's/#   PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# enable ssh key authentication
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# set port to 22
sed -i 's/#   Port 22/Port 22/' /etc/ssh/sshd_config

# disable root login via ssh
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# only allow the administrator user to log in via ssh
echo "AllowUsers administrator" >> /etc/ssh/sshd_config

# restart ssh daemon
systemctl restart sshd