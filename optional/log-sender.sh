#!/bin/bash

cat ./configs/rsyslog-sender.conf > /etc/rsyslog.d/sender.conf

systemctl restart rsyslog