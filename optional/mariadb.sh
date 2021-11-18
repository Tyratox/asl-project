#!/bin/bash

# generate random root password
DB_ROOT_PASSWD=$(openssl rand -base64 32 | tr '\n' ' ' | sed 's/ //g' | cut -c 1-32)

# store it
echo $DB_ROOT_PASSWD > /root/mysql_root_pass
chmod 600 /root/mysql_root_pass

# generate random username
DB_USER=$1

# generate random password
DB_PASSWD=$2

# install the mariadb server
apt -y install mariadb-server

# set root password
sed -i "s toor $DB_ROOT_PASSWD g" ./configs/sql/installation.sql

# set user credentials
sed -i "s uname $DB_USER g" ./configs/sql/installation.sql
sed -i "s pwd $DB_PASSWD g" ./configs/sql/installation.sql
sed -i "s uname root g" ./configs/ormconfig.json
sed -i "s pwd $DB_ROOT_PASSWD g" ./configs/ormconfig.json

# secure the installation
# See https://stackoverflow.com/a/35004940/2897827
# Also create the database imovies
mysql -sfu root < "./configs/sql/installation.sql"

