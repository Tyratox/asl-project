#!/bin/bash

# allow http rsyslogd traffic
firewall-cmd --permanent --add-port={514/tcp}
firewall-cmd --reload

cat ./configs/rsyslog-receiver.conf >> /etc/rsyslog.conf

# restart
systemctl restart rsyslog