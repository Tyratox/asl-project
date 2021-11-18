#!/bin/bash

TYPE=$1

# allow ryslog to use tls
apt-get -y install rsyslog-gnutls

if [ "$TYPE" == "webapp" ]; then
  cp ./configs/rsyslog/webapp.conf /etc/rsyslog.d/sender.conf
fi

if [ "$TYPE" == "certificate-authority" ]; then
  cp ./configs/rsyslog/certificate-authority.conf /etc/rsyslog.d/sender.conf
fi

systemctl restart rsyslog