#!/bin/bash

$DB_PASSWD = $1 

# install the mariadb server
apt -y install mariadb-server

# set db password
sed -i "s/toor/$DB_PASSWD/" ./configs/sql/mysql_secure_installation.sql

# secure the installation except for the password (set to toor)
# See https://stackoverflow.com/a/35004940/2897827
mysql -sfu root < "./configs/sql/mysql_secure_installation.sql"

