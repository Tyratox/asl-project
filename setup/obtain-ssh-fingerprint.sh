#!/bin/bash

ssh-keyscan -H backup.imovies.ch >> /home/backupr/.ssh/known_hosts
chown backupr:backupr /home/backupr/.ssh/known_hosts
chmod 700 /home/backupr/.ssh/known_hosts