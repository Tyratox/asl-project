#!/bin/bash

cp ./configs/nginx/redirect-http.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/redirect-http.conf /etc/nginx/sites-enabled/