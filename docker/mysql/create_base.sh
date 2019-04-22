#!/usr/bin/env bash

MYPASSWD=$RANDOM$RANDOM$RANDOM
mysqladmin -u root password $MYPASSWD;

mysql -uroot -p$MYPASSWD "CREATE DATABASE IF NOT EXISTS domain_statistic DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -uroot -p$MYPASSWD "CREATE USER 'pma'@'%' IDENTIFIED BY 'pma';"
mysql -uroot -p$MYPASSWD "GRANT ALL PRIVILEGES ON * . * TO 'pma'@'%';"
mysql -uroot -p$MYPASSWD "FLUSH PRIVILEGES;"
mysql -uroot -p$MYPASSWD "domain_statistic < /root/structure.sql;"
touch /root/.my.cnf;
echo "[client]" > /root/.my.cnf 
echo "password=$MYPASSWD" >> /root/.my.cnf

echo "Done"