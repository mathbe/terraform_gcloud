#!/bin/bash

WEB_ROOT="/opt/websites"
WEB_DIR="${WEB_ROOT}/guestbook"

export DEBIAN_FRONTEND=noninteractive

# system update and packages install
apt-get update
apt-get upgrade -y
apt-get install -y mysql-server

# database setup
mysql -u root < /tmp/setup.d/user.sql
mysql -u root guestbook < /tmp/setup.d/schema.sql

sed -i 's/.*bind-address.*/bind-address = 10.10.10.10/g' /etc/mysql/my.cnf

service mysql restart

exit 0

# EOF
