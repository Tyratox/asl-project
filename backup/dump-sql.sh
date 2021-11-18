#!/bin/bash

mkdir -p /home/webapp/sql-dump/
mysqldump -u $(cat /home/webapp/sql_user) -p=$(cat /home/webapp/sql_pass) imovies > /home/webapp/sql-dump/imovies_dump.sql