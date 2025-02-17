#!/bin/bash
while ! mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -h ${MYSQL_HOST}  -e ";" ; do
	sleep 1
done	
mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -h ${MYSQL_HOST} ${MYSQL_DATABASE} < /var/www/html/biblioteca.sql
apache2ctl -D FOREGROUND
