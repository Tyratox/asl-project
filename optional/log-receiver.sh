#!/bin/bash

# allow http rsyslogd traffic
firewall-cmd --permanent --add-port=10514/tcp
firewall-cmd --reload

cat ./configs/rsyslog-receiver.conf > /etc/rsyslog.d/receiver.conf

# restart
systemctl restart rsyslog