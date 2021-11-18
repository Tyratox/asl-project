#!/bin/bash

# allow http rsyslogd traffic
firewall-cmd --permanent --add-port=10514/tcp
firewall-cmd --reload

# allow ryslog to use tls
apt-get -y install rsyslog-gnutls

cp ./configs/rsyslog/receiver.conf /etc/rsyslog.d/receiver.conf

# restart
systemctl restart rsyslog