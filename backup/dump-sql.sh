#!/bin/bash

mkdir -p /home/webapp/sql-dump/
mysqldump --user="$(cat /home/webapp/sql_user)" --password="$(cat /home/webapp/sql_pass)" imovies > /home/webapp/sql-dump/imovies_dump.sql