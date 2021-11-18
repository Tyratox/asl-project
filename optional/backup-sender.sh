#!/bin/bash

HOSTNAME=$1

# install inotifywait, entr and rsync for backing up files
apt -y install inotify-tools entr rsync

# install c++ compiler
apt -y install build-essential

# add user that runs the backup scripts
adduser --gecos "" --disabled-password backupr
./optional/user-dir-auditing.sh "backupr"

# generate 32 byte = 256 bit key: openssl rand 32 > ./symmetric.key
# generate 16 byte = 128 bit IV: openssl rand 16 -hex > ./IV
# encrypt: openssl enc -aes-256-cbc -a -A -iv $(cat ./IV) -kfile ./symmetric.key -in ./input.txt -out ./encrypted
# pack IV and encrypted file together: tar -cf ./encrypted.tar ./IV ./encrypted
# unpack tar file: tar -xf ./encrypted.tar
# decrypt: openssl enc -d -aes-256-cbc -a -A -iv $(cat ./IV) -kfile ./symmetric.key -in ./encrypted -out ./decrypted

# copy the encryption to /opt/backup

mkdir /opt/backup
cp "../asl-project-keys/backup-keys/$HOSTNAME.aes-256.key" /opt/backup/aes-256.key

# build backup binary
./backup/build-encrypt.sh ./backup/encrypt.cpp /opt/backup/encrypt

# move backup scripts to this folder
cp ./backup/backupd.sh /opt/backup
cp ./backup/encryptd.sh /opt/backup
cp ./backup/dump-sql.sh /opt/backup

chown -R backupr:backupr /opt/backup
chmod -R 700 /opt/backup

# setup ssh
mkdir /home/backupr/.ssh
cp "../asl-project-keys/ssh/$HOSTNAME-key.pub" /home/backupr/.ssh/id_backup
cp "../asl-project-keys/ssh/$HOSTNAME-key" /home/backupr/.ssh/id_backup
cp "./configs/ssh/$HOSTNAME" /home/backupr/.ssh/config

chown -R backupr:backupr /home/backupr/.ssh
chmod -R 700 /home/backupr/.ssh

# /opt/backup/encryptd.sh /opt/backup/encrypt /opt/CA /opt/CA_enc aes-256-cbc /opt/backup/aes-256.key

# on backup
# 1. encrypt using aes key
# 2. copy using ssh
# 3. add to local backup folder using https://github.com/rdiff-backup/rdiff-backup