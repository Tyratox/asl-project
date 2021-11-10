#!/bin/bash

DB_PASSWD=$1 

# install the mariadb server
apt -y install mariadb-server

# set db password
sed -i "s/toor/$DB_PASSWD/" ./configs/sql/secure_installation.sql

# secure the installation
# See https://stackoverflow.com/a/35004940/2897827
# Also create the database imovies
mysql -sfu root < "./configs/sql/installation.sql"

