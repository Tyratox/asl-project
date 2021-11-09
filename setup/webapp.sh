#!/bin/bash

IP=$1

# set the hostname
./optional/set-hostname.sh "imovies.ch"

# general debian hardening
./debian-hardening.sh

# set the ip of the computer to 192.168.0.1
sed -i 's/address 192.168.0.0/address 192.168.0.1/' /etc/network/interfaces

# setup rsyslod sender
./optional/log-sender.sh

# setup nginx
./optional/nginx.sh

# redirect http to https
./optional/nginx-tls-only.sh

# install static page
./optional/nginx-webapp.sh

# install curl
apt -y install curl

# temorarily redirect asl.localhost to host computer

echo "$IP asl.localhost" >> /etc/hosts

# download certificate
curl -o certificate.crt http://asl.localhost/imovies.ch/imovies.ch.crt
# and private key
curl -o private.key http://asl.localhost/imovies.ch/imovies.ch.key

# move them to /opt/tls
mkdir /opt/tls
mv certificate.crt /opt/tls
mv private.key /opt/tls

# only allow reading the files to the owner and the group
chmod -R 700 /opt/tls
# set the owner to root, nobody should be able to read this files except for the root user
chown -R root:root /opt/tls

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

git clone https://github.com/Tyratox/asl-ca-frontend /srv/asl-ca-frontend

# add .env file
cp ./configs/.env-frontend /srv/asl-ca-frontend

# install npm dependencies
yarn --cwd /srv/asl-ca-frontend install

# build webapp
yarn --cwd /srv/asl-ca-frontend build

# generate static files
yarn --cwd /srv/asl-ca-frontend export

# restart nginx
systemctl restart nginx

./cleanup.sh