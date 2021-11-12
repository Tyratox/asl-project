#!/bin/bash

# set the hostname
./optional/set-hostname.sh "client1.imovies.ch"

# general debian hardening is not needed for the client

# except for sudo
apt -y install sudo

# now install the custom root certificate. extension must be .crt
cp ./public-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# resolve hostnames using /etc/hosts
echo "192.168.0.1 imovies.ch" >> /etc/hosts
echo "192.168.0.2 ca.imovies.ch" >> /etc/hosts
echo "192.168.0.2 auth.imovies.ch" >> /etc/hosts
echo "192.168.0.3 backup.imovies.ch" >> /etc/hosts
echo "192.168.0.254 internal-fw.imovies.ch" >> /etc/hosts

# change network interface name s.t. the first interface is called eth0
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

cat ./configs/client-interfaces.conf > /etc/network/interfaces

# set the ip of the computer
sed -i 's/address 10.0.0.0/address 10.0.0.1/' /etc/network/interfaces

./cleanup.sh