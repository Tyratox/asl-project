#!/bin/bash

echo "If you want to generate the pfsense config files you have to do this first!"
echo "Make sure asl-project-keys is placed at ../asl-project-keys"
read -n 1

# set the hostname
./optional/set-hostname.sh "client1.imovies.ch"

# general debian hardening is not needed for the client

# except for sudo
apt -y install sudo

# now install the custom root certificate. extension must be .crt
cp ../asl-project-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# resolve hostnames using /etc/hosts
echo "192.168.0.1 imovies.ch" >> /etc/hosts
echo "192.168.0.2 ca.imovies.ch" >> /etc/hosts
echo "192.168.0.2 auth.imovies.ch" >> /etc/hosts

echo "# 192.168.0.254 fw-1.imovies.ch" >> /etc/hosts
echo "10.0.0.254 fw-1.imovies.ch" >> /etc/hosts

echo "# 172.16.0.254 fw-2.imovies.ch" >> /etc/hosts
echo "10.0.0.253 fw-2.imovies.ch" >> /etc/hosts

echo "172.16.0.1 backup.imovies.ch" >> /etc/hosts

./cleanup.sh