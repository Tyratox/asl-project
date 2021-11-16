#!/bin/bash

# generate random root password
DB_ROOT_PASSWD=$(openssl rand -base64 32 | tr '\n' ' ' | sed 's/ //g' | cut -c 1-32)

# generate random username
DB_USER=$(openssl rand -base64 16 | tr '\n' ' ' | sed 's/ //g' | cut -c 1-16)

# generate random password
DB_PASSWD=$(openssl rand -base64 32 | tr '\n' ' ' | sed 's/ //g' | cut -c 1-32)

# install the mariadb server
apt -y install mariadb-server

# set root password
sed -i "s/toor/$DB_ROOT_PASSWD/" ./configs/sql/installation.sql

# set user credentials
sed -i "s/uname/$DB_USER/" ./configs/sql/installation.sql
sed -i "s/pwd/$DB_PASSWD/" ./configs/sql/installation.sql
sed -i "s/uname/$DB_USER/" ./configs/ormconfig.json
sed -i "s/pwd/$DB_PASSWD/" ./configs/ormconfig.json

# secure the installation
# See https://stackoverflow.com/a/35004940/2897827
# Also create the database imovies
mysql -sfu root < "./configs/sql/installation.sql"

