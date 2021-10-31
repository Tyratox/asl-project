#!/bin/bash

# set the hostname
./optional/set-hostname.sh "client1.imovies.ch"

# general debian hardening is not needed for the client

# except for sudo
apt -y install sudo

# and the networking setup (e.g. root certificate)
./networking.sh
# now install the custom root certificate for firefox as well
# see https://bgstack15.wordpress.com/2018/10/04/firefox-trust-system-trusted-certificates/
dirname $(grep -IrL 'p11-kit-trust.so' ~/.mozilla/firefox/*/pkcs11.txt) | xargs -t -d '\n' -I {} modutil -dbdir sql:{} -force -add 'PKCS #11 Trust Storage Module' -libfile /usr/lib64/pkcs11/p11-kit-trust.so


cp ./public-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# set the ip of the computer
sed -i 's/address 192.168.0.0/address 192.168.0.4/' /etc/network/interfaces

./cleanup.sh