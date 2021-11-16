UPDATE mysql.user SET Password=PASSWORD('toor') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

CREATE DATABASE imovies;
CREATE USER 'uname'@'localhost' identified by 'pwd';
GRANT SELECT, INSERT, UPDATE, DELETE ON `imovies`.* TO 'uname'@'localhost';
ALTER USER 'uname'@'localhost' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0; 

FLUSH PRIVILEGES;
