#!/bin/bash

# set the hostname
./optional/set-hostname.sh "client1.imovies.ch"

# general debian hardening is not needed for the client

# except for sudo
apt -y install sudo

# and the networking setup (e.g. root certificate)
./networking.sh

# set the ip of the computer
sed -i 's/address 192.168.0.0/address 192.168.0.4/' /etc/network/interfaces

# install curl
apt -y install curl

# temorarily redirect asl.localhost to host computer

./cleanup.sh