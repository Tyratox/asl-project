#!/bin/bash

# install the mariadb server
apt -y install mariadb-server

# secure the installation except for the password (set to toor)
# See https://stackoverflow.com/a/35004940/2897827
mysql -sfu root < "./configs/sql/mysql_secure_installation.sql"

