#!/bin/bash

# use firewalld instead of iptables, uses iptables under the hood
# SSH and DHCP is enabled by default and it is enabled automatically
apt -y install firewalld

# now install the custom root certificate. extension must be .crt
cp ./public-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# setup dns using /etc/hosts
echo "192.168.0.1 imovies.ch" >> /etc/hosts
echo "192.168.0.2 ca.imovies.ch" >> /etc/hosts
echo "192.168.0.3 backup.imovies.ch" >> /etc/hosts