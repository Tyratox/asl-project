#!/bin/bash

echo "Make sure asl-project-keys is placed at ../asl-project-keys"
read -n 1

# set the hostname
./optional/set-hostname.sh "imovies.ch"

# general debian hardening
./debian-hardening.sh "service"

# set the ip of the computer to 192.168.0.1
sed -i 's/address 192.168.0.0/address 192.168.0.1/' /etc/network/interfaces

# setup rsyslod sender
./optional/log-sender.sh "webapp"

# setup nginx
./optional/nginx.sh

# redirect http to https
./optional/nginx-tls-only.sh

# install static page
./optional/nginx-webapp.sh

# install curl
apt -y install curl

# move them to /opt/tls
mkdir /opt/tls
cp ../asl-project-keys/imovies.ch/imovies.ch.crt /opt/tls
cp ../asl-project-keys/imovies.ch/imovies.ch.key /opt/tls

# setup symlinks for rsyslog
ln -s /opt/tls/imovies.ch.crt /opt/tls/certificate.crt
ln -s /opt/tls/imovies.ch.key /opt/tls/private.key

# only allow root reading the files
chmod -R 700 /opt/tls
# set the owner to root, nobody should be able to read this files except for the root user
chown -R root:root /opt/tls

# install gnupg, required for the following
apt -y install gnupg

# add yarn repo to apt
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt update

# install nodejs and yarn
apt -y install nodejs yarn

git clone https://github.com/asl-project-group-7-2021/asl-ca-frontend /srv/asl-ca-frontend

# add .env file
cp ./configs/.env-frontend /srv/asl-ca-frontend/.env

# install npm dependencies
yarn --cwd /srv/asl-ca-frontend install

# allow executing files
mount -o remount,exec /srv/

# build webapp
yarn --cwd /srv/asl-ca-frontend build

# generate static files
yarn --cwd /srv/asl-ca-frontend export

# delete node_modules
rm -rf /srv/asl-ca-frontend/node_modules

# set permissions of the folder

chown www-data:www-data /srv/asl-ca-frontend/
chmod 750 /srv/asl-ca-frontend/

# restart nginx
systemctl restart nginx

./cleanup.sh