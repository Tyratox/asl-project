#!/bin/bash

cat ./configs/rsyslog-sender.conf >> /etc/rsyslog.conf

systemctl restart rsyslog