#!/bin/bash

# use firewalld instead of iptables, uses iptables under the hood
# SSH and DHCP is enabled by default and it is enabled automatically
apt -y install firewalld

# disable dhcp, we use static IPs
firewall-cmd –-permanent –-remove-service=dhcpv6-client

# now install the custom root certificate. extension must be .crt
cp ./public-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# setup dns using /etc/hosts
echo "192.168.0.1 frontend.imovies.ch" >> /etc/hosts
echo "192.168.0.2 ca.imovies.ch" >> /etc/hosts
echo "192.168.0.2 auth.imovies.ch" >> /etc/hosts
echo "192.168.0.3 backup.imovies.ch" >> /etc/hosts
echo "192.168.0.254 pfsense.imovies.ch" >> /etc/hosts

# change network interface name s.t. the first interface is called eth0
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

cat ./configs/interfaces.conf > /etc/network/interfaces