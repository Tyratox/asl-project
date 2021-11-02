#!/bin/bash

cp ./configs/nginx/ca-backend.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/ca-backend.conf /etc/nginx/sites-enabled/