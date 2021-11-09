#!/bin/bash

cp ./configs/nginx/ca-frontend.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/ca-frontend.conf /etc/nginx/sites-enabled/