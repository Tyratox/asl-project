#!/bin/bash

cp ./configs/nginx/sample-tls.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/sample-tls.conf /etc/nginx/sites-enabled/