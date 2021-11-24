#!/bin/bash

TYPE=$1

# use firewalld instead of iptables, uses iptables under the hood
# SSH and DHCP are allowed by default and the firewall is enabled automatically
apt -y install firewalld

# disable dhcp, we use static IPs
firewall-cmd --permanent --remove-service=dhcpv6-client

# now install the custom root certificate. extension must be .crt
cp ../asl-project-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# resolve hostnames using /etc/hosts
echo "192.168.0.1 imovies.ch" >> /etc/hosts
echo "192.168.0.2 ca.imovies.ch" >> /etc/hosts
echo "192.168.0.2 auth.imovies.ch" >> /etc/hosts

echo "10.0.0.1 client.imovies.ch" >> /etc/hosts

echo "172.16.0.1 backup.imovies.ch" >> /etc/hosts

if [ "$TYPE" == "service" ]; then
  # one of the service servers
  echo "192.168.0.254 fw-1.imovies.ch" >> /etc/hosts
  echo "10.0.0.253 fw-2.imovies.ch" >> /etc/hosts
else
  # the backup server
  echo "10.0.0.254 fw-1.imovies.ch" >> /etc/hosts
  echo "172.16.0.254 fw-2.imovies.ch" >> /etc/hosts
fi


# change network interface name s.t. the first interface is called eth0
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

cat ./configs/interfaces.conf > /etc/network/interfaces