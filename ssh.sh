#!/bin/bash

TYPE=$1

mkdir /home/administrator/.ssh
# create new file with authorized keys
cat ./public-keys/administrator-key.pub > /home/administrator/.ssh/authorized_keys

chown -R administrator:administrator /home/administrator/.ssh

# disable password authentication
sed -i 's/#   PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# enable ssh key authentication
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# set port to 22
sed -i 's/#   Port 22/Port 22/' /etc/ssh/sshd_config

# disable root login via ssh
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

if [ "$TYPE" == "backup" ]; then
  # allow the administrator user and the backup user to log in via ssh
  echo "AllowUsers administrator ca-backup" >> /etc/ssh/sshd_config
else
  # only allow the administrator user to log in via ssh
  echo "AllowUsers administrator" >> /etc/ssh/sshd_config
fi

# restart ssh daemon
systemctl restart sshd