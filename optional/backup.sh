#!/bin/bash

HOSTNAME=$1

# generate 32 byte = 256 bit key: openssl rand 32 > ./symmetric.key
# generate 16 byte = 128 bit IV: openssl rand 16 -hex > ./IV
# encrypt: openssl enc -aes-256-cbc -a -A -iv $(cat ./IV) -kfile ./symmetric.key -in ./input.txt -out ./encrypted
# pack IV and encrypted file together: tar -cf ./encrypted.tar ./IV ./encrypted
# unpack tar file: tar -xf ./encrypted.tar
# decrypt: openssl enc -d -aes-256-cbc -a -A -iv $(cat ./IV) -kfile ./symmetric.key -in ./encrypted -out ./decrypted

# copy the encryption to /opt/backup

mkdir /opt/backup
cp "../asl-project-keys/backup-keys/$HOSTNAME.aes-256.key" /opt/backup/aes-256.key
chown -R root:root /opt/backup
chmod -R 700 /opt/backup

# on backup
# 1. encrypt using aes key
# 2. copy using ssh
# 3. add to local backup folder using https://github.com/rdiff-backup/rdiff-backup