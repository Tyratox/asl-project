#!/bin/bash

# set the hostname
./optional/set-hostname.sh "ca.imovies.ch"

# general debian hardening
./debian-hardening.sh

# set the ip of the computer
sed -i 's/address 192.168.0.0/address 192.168.0.2/' /etc/network/interfaces

# setup rsyslod sender
./optional/log-sender.sh

# setup nginx
./optional/nginx.sh

# redirect http to https
./optional/nginx-tls-only.sh

# install sample tls page
./optional/nginx-sample-tls.sh

# install curl
apt -y install curl

# temorarily redirect asl.localhost to host computer

echo "192.168.178.104 asl.localhost" >> /etc/hosts

# download certificate
curl -o certificate.crt http://asl.localhost/ca.imovies.ch/ca.imovies.ch.crt
# and private key
curl -o private.key http://asl.localhost/ca.imovies.ch/ca.imovies.ch.key

# move them to /opt/tls
mkdir /opt/tls
mv certificate.crt /opt/tls
mv private.key /opt/tls

# only allow reading the files to the owner and the group
chmod -R 700 /opt/tls
# set the owner to root, nobody should be able to read this files except for the root user
chown -R root:root /opt/tls

# download CA certificate for the project
curl -o ca.key http://asl.localhost/mail-ca.key

# move it to /opt/CA
# move them to /opt/tls
mkdir /opt/CA
mv ca.key /opt/CA

# only allow reading the files to the owner and the group
chmod -R 700 /opt/CA
# set the owner to root, nobody should be able to read this files except for the root user
chown -R root:root /opt/CA

# remove entry from hosts file
sed -i 's/192.168.178.104 asl.localhost//' /etc/hosts

# uninstall curl
apt -y purge curl

# install nodejs
apt -y install nodejs

# install an sql server
./optional/mariadb.sh

# TODO: install the application

# install the nginx configuration

# download the backend

# setup pm2 process autostart of the backend nodejs service

# restart nginx
systemctl restart nginx

./cleanup.sh