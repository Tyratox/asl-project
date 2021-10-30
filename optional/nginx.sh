#!/bin/bash

# install nginx
apt -y install nginx

# hide nginx/OS information
# sed -i "s/\t# server_tokens off;/\tserver_tokens off;/" /etc/nginx/nginx.conf

cat ./configs/nginx.conf > /etc/nginx/nginx.conf

# restart nginx
systemctl restart nginx

# delete default site
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default

# allow http traffic, i.e. allow ports 80 & 443 for nginx
# NOTE: all servers we setup have nginx, only the client doesn't
firewall-cmd --permanent --add-port={80/tcp,443/tcp}
firewall-cmd --reload