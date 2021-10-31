#!/bin/bash

# delete old rotated/compressed logs
find /var/log -type f -regex ".*\.gz$"
find /var/log -type f -regex ".*\.[0-9]$"

# empty all existing log files
for i in $(find /var/log -type f); do cat /dev/null > $i; done

# uninstall git
apt -y purge git

# run autoremove
apt -y autoremove

# reboot
reboot