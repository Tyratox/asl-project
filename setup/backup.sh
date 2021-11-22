#!/bin/bash

# set the hostname
./optional/set-hostname.sh "backup.imovies.ch"

# general debian hardening
./debian-hardening.sh "backup"

adduser --gecos "" --disabled-password ca-backup
./optional/user-dir-auditing.sh "ca-backup"
# all files created by this user should remain readable by versiond
chfn -o umask=137 ca-backup

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

# install backup user ssh keys
mkdir /home/ca-backup/.ssh
cat ../asl-project-keys/ssh/ca.imovies.ch-key.pub > /home/ca-backup/.ssh/authorized_keys
chmod 600 /home/ca-backup/.ssh/authorized_keys

# own all files in home directories
chown -R ca-backup:ca-backup /home/ca-backup

# create versioning daemon
adduser --gecos "" --disabled-password versionr
./optional/user-dir-auditing.sh "versionr"

mkdir -p /opt/versioning/
cp ./backup/versiond.sh /opt/versioning

# create folders for the different servers / backup users
mkdir -p /opt/versioning/ca.imovies.ch

chown -R versionr:versionr /opt/versioning
chmod -R 700 /opt/versioning

# allow versionr to read ca-backup files
usermod -a -G ca-backup backupr
chmod -R 740 /home/ca-backup

# versiond
cp ./configs/systemd/versiond-ca.service /etc/systemd/system/versiond-ca.service
chmod 644 /etc/systemd/system/versiond-ca.service
systemctl enable versiond-ca

./cleanup.sh