#!/bin/bash

IP=$1

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
./optional/nginx-ca.sh

# install curl
apt -y install curl

# temorarily redirect asl.localhost to host computer

echo "$IP asl.localhost" >> /etc/hosts

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
curl -o cakey.pem http://asl.localhost/cakey.pem
curl -o cacert.pem http://asl.localhost/cacert.pem

# move it to /opt/CA
mkdir -p /opt/CA/private/users
mkdir -p /opt/CA/crl
mkdir -p /opt/CA/newcerts
mkdir -p /opt/CA/requests

touch /opt/CA/index.txt
touch /opt/CA/crl/crl.pem

echo "01" > /opt/CA/serial
echo "01" > /opt/CA/crlnumber

mv cakey.pem /opt/CA/private/
mv cacert.pem /opt/CA/


# only allow reading the files to the owner and the group
chmod -R 700 /opt/CA
# set the owner to root, nobody should be able to read this files except for the root user
chown -R root:root /opt/CA

# remove entry from hosts file
sed -i "s/$IP asl.localhost//" /etc/hosts

# install gnupg, required for the following
apt -y install gnupg

# add yarn repo to apt
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt update

# install nodejs and yarn
apt -y install nodejs yarn

# add user for running the node process
adduser --gecos "" --disabled-password webapp

mkdir -p /opt/pm2/
cp ./configs/pm2/backend.config.js /opt/pm2/

# add yarn to the PATH of webapp
echo 'export PATH="$(yarn global bin):$PATH"' >> /home/webapp/.bashrc

# install pm2 (node process manager) and ts-node (typescript interpreter)
su -l -c "yarn global add pm2 ts-node" webapp

git clone https://github.com/Tyratox/asl-ca-backend /opt/pm2/asl-ca-backend

chown -R webapp:webapp /opt/pm2/
chmod -R 700 /opt/pm2/

# install yarn dependencies
su -c "cd /opt/pm2/asl-ca-backend && yarn install" webapp

exit;

# run backend
pm2 start /opt/pm2/asl-ca-backend/backend.config.js

# save running process
pm2 save



# install an sql server
./optional/mariadb.sh

# TODO: install the application

# install the nginx configuration

# download the backend

# setup pm2 process autostart of the backend nodejs service

# restart nginx
systemctl restart nginx

./cleanup.sh