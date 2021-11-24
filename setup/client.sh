#!/bin/bash

PFSENSE_USERNAME=$1
PFSENSE_PWD=$2

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

# change network interface name s.t. the first interface is called eth0
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

cat ./configs/client-interfaces.conf > /etc/network/interfaces

# set the ip of the computer
sed -i 's/address 10.0.0.0/address 10.0.0.1/' /etc/network/interfaces

# if an argument was passed, edit the config file
if [ -n "$PFSENSE_PWD" ]
then
  OLD_HASH='$2y$10$ToXr.qZNhukmRUOUaddJFOhnn07fs1/9U/M/mUEEXDkW738orfgpK'
  # install htpasswd, required for generating a bcrypt hash
  apt -y install apache2-utils
  HASH=$(htpasswd -bnBC 10 "" "$PFSENSE_PWD" | tr -d ':\n')
  apt -y purge apache2-utils

  # replace hash inside the config file
  sed -i "s $OLD_HASH $HASH " ./configs/pfsense/fw-1.imovies.ch.xml
  sed -i "s $OLD_HASH $HASH " ./configs/pfsense/fw-2.imovies.ch.xml
fi

if [ -n "$PFSENSE_USERNAME" ]
then
  sed -i "s <name>admin</name> <name>$PFSENSE_USERNAME</name> " ./configs/pfsense/fw-1.imovies.ch.xml
  sed -i "s <name>admin</name> <name>$PFSENSE_USERNAME</name> " ./configs/pfsense/fw-2.imovies.ch.xml
  sed -i "s/admin@/$PFSENSE_USERNAME@/g" ./configs/pfsense/fw-1.imovies.ch.xml
  sed -i "s/admin@/$PFSENSE_USERNAME@/g" ./configs/pfsense/fw-2.imovies.ch.xml
fi

CRT_1_BASE64=$(cat ../asl-project-keys/fw-1.imovies.ch/fw-1.imovies.ch.crt | base64 -w 0)
CRT_2_BASE64=$(cat ../asl-project-keys/fw-2.imovies.ch/fw-2.imovies.ch.crt | base64 -w 0)

KEY_1_BASE64=$(cat ../asl-project-keys/fw-1.imovies.ch/fw-1.imovies.ch.key | base64 -w 0)
KEY_2_BASE64=$(cat ../asl-project-keys/fw-2.imovies.ch/fw-2.imovies.ch.key | base64 -w 0)

# | is not part of base64
sed -i "s|<crt>.*</crt>|<crt>$CRT_1_BASE64</crt>|" ./configs/pfsense/fw-1.imovies.ch.xml
sed -i "s|<crt>.*</crt>|<crt>$CRT_2_BASE64</crt>|" ./configs/pfsense/fw-2.imovies.ch.xml

sed -i "s|<prv>.*</prv>|<prv>$KEY_1_BASE64</prv>|" ./configs/pfsense/fw-1.imovies.ch.xml
sed -i "s|<prv>.*</prv>|<prv>$KEY_2_BASE64</prv>|" ./configs/pfsense/fw-2.imovies.ch.xml

./cleanup.sh