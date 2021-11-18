#!/bin/bash

# set the hostname
./optional/set-hostname.sh "backup.imovies.ch"

# general debian hardening
./debian-hardening.sh "backup"

adduser --gecos "" --disabled-password ca-backup
./optional/user-dir-auditing.sh "ca-backup"

mkdir /home/ca-backup/.ssh
cat ./public-keys/ca.imovies.ch-key.pub > /home/ca-backup/.ssh/authorized_keys

# restart ssh
systemctl restart sshd

# set the ip of the computer
sed -i 's/address 192.168.0.0/address 172.16.0.1/' /etc/network/interfaces
sed -i 's/network 192.168.0.0/network 172.16.0.0/' /etc/network/interfaces
sed -i 's/netmask 255.255.255.0/netmask 255.255.255.0/' /etc/network/interfaces
sed -i 's/gateway 192.168.0.254/gateway 172.16.0.254/' /etc/network/interfaces

# setup rsyslod receiver
./optional/log-receiver.sh

# setup rsyslod receiver
./optional/backup-receiver.sh

# install curl
apt -y install curl

# download certificates and private keys
git clone https://github.com/asl-project-group-7-2021/asl-project-keys.git ../asl-project-keys

# move them to /opt/tls
mkdir /opt/tls
cp ../asl-project-keys/backup.imovies.ch/backup.imovies.ch.crt /opt/tls
cp ../asl-project-keys/backup.imovies.ch/backup.imovies.ch.key /opt/tls

# setup symlinks for rsyslog
ln -s /opt/tls/backup.imovies.ch.crt /opt/tls/certificate.crt
ln -s /opt/tls/backup.imovies.ch.key /opt/tls/private.key

# only allow root reading the files
chmod -R 700 /opt/tls
# set the owner to root, nobody should be able to read this files except for the root user
chown -R root:root /opt/tls

./cleanup.sh