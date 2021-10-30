#!/bin/bash
HOSTNAME=$1

hostnamectl set-hostname $HOSTNAME

sed -i "s/hostname/$HOSTNAME/" /etc/hosts
# initial image had the hostname certificate-authority, just for backwards compatibility
sed -i "s/certificate-authority/$HOSTNAME/" /etc/hosts