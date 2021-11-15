#!/bin/bash

# allow ryslog to use tls
apt-get -y install rsyslog-gnutls

cat ./configs/rsyslog-sender.conf > /etc/rsyslog.d/sender.conf

systemctl restart rsyslog