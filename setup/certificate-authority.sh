#!/bin/bash

# set the hostname
./optional/set-hostname.sh "ca.imovies.ch"

# general debian hardening
./debian-hardening.sh

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

# remove entry from hosts file
sed -i 's/192.168.178.104 asl.localhost//' /etc/hosts

# uninstall curl
apt -y purge curl

# restart nginx
systemctl restart nginx

# install nodejs
apt-get install nodejs