#!/bin/bash

# set the hostname
./optional/set-hostname.sh "client1.imovies.ch"

# general debian hardening is not needed for the client

# except for sudo
apt -y install sudo

# and the networking setup (e.g. root certificate)
./networking.sh

apt -y install libnss3-tools

mkdir /usr/lib/mozilla/certificates
cp ./public-keys/web-root.crt /usr/lib/mozilla/certificates/imovies.crt

# now install the custom root certificate for firefox as well
# see https://stackoverflow.com/a/2760345/2897827 and https://stackoverflow.com/a/48424709/2897827
for certDB in $(find  ~/.mozilla* ~/.thunderbird -name "cert9.db")
do
  certDir=$(dirname ${certDB});
  certutil -A -n "iMovies Root Certificate" -t "TCu,Cuw,Tuw" -i /usr/lib/mozilla/certificates/imovies.crt -d sql:${certDir}
done


cp ./public-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# set the ip of the computer
sed -i 's/address 192.168.0.0/address 192.168.0.4/' /etc/network/interfaces

./cleanup.sh