#!/bin/bash

IP=$1
DB_PASSWD="toor"

if [ -z "$IP" ]
then
  echo "Usage: ./setup/certificate-authority.sh HOST_IP"
  exit
fi

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
# apparently nginx is fine with just the certificate as an empty CRL
cp /opt/CA/cacert.pem /opt/CA/crl/revoked.pem

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
# add user for owning the CA folder and running the setuid binary
adduser --gecos "" --disabled-password webapp-ca

mkdir -p /opt/pm2/
cp ./configs/pm2/backend.config.js /opt/pm2/

# add yarn to the PATH of webapp
echo 'export PATH="$(yarn global bin):$PATH"' >> /home/webapp/.bashrc

# install pm2 (node process manager) and ts-node (typescript interpreter)
su -l -c "yarn global add pm2 ts-node" webapp

git clone https://github.com/Tyratox/asl-ca-backend /opt/pm2/asl-ca-backend

# add database configuration file
cp ./configs/ormconfig.json /opt/pm2/asl-ca-backend

# change credentials
sed -i "s/toor/$DB_PASSWD/" /opt/pm2/asl-ca-backend/ormconfig.json

# add .env file
cp ./configs/.env-backend /opt/pm2/asl-ca-backend/.env

chown -R webapp:webapp /opt/pm2/
chmod -R 700 /opt/pm2/

# install an sql server
./optional/mariadb.sh $DB_PASSWD

# install yarn dependencies
su -c "cd /opt/pm2/asl-ca-backend && yarn install" webapp
# build backend
su -c "cd /opt/pm2/asl-ca-backend && yarn build" webapp
# run migrations
su -c "cd /opt/pm2/asl-ca-backend && yarn migrations:run" webapp

# update openssl config
sed -i 's/.\/demoCA/\/opt\/CA\//' /etc/ssl/openssl.cnf

# install c++ compiler
apt -y install build-essential

# allow webapp user to reload nginx without a password
echo "webapp-ca ALL=(ALL) NOPASSWD: /usr/sbin/nginx -s reload" > /etc/sudoers.d/nginx

# build binary used by the backend
/opt/pm2/asl-ca-backend/build-ca-utility.sh /opt/pm2/asl-ca-backend/src/ca-utility.cpp /opt/CA/ca-utility /opt/CA/ /etc/ssl/openssl.cnf /usr/bin/openssl

# remove c++ compiler
apt -y purge build-essential

# only allow reading the files to the owner and the group
chmod -R 700 /opt/CA
# set the owner to root, nobody should be able to read this files except for the root user
chown -R webapp-ca:root /opt/CA

# change ownership of the binary
chown webapp-ca:webapp /opt/CA/ca-utility
chown webapp-ca:webapp /opt/CA

# setsuid bit
chmod u+s /opt/CA/ca-utility
# allow the owner to execute it
chmod u+x /opt/CA/ca-utility

# allow the webapp user to execute it
chmod g+x /opt/CA
chmod g+x /opt/CA/ca-utility

# disallow access for everyone else
chmod o-rwx /opt/CA/ca-utility

# run backend
su -l -c "/home/webapp/.yarn/bin/pm2 start /opt/pm2/backend.config.js" webapp

# save running process
su -l -c "/home/webapp/.yarn/bin/pm2 save" webapp

# setup pm2 process autostart of the backend nodejs service
env PATH=$PATH:/usr/bin /home/webapp/.config/yarn/global/node_modules/pm2/bin/pm2 startup systemd -u webapp --hp /home/webapp

# restart nginx
systemctl restart nginx

./cleanup.sh