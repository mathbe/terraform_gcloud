#!/bin/bash

WEB_ROOT="/opt/websites"
WEB_DIR="${WEB_ROOT}/guestbook"

export DEBIAN_FRONTEND=noninteractive

# system update and packages install
apt-get update
apt-get upgrade -y
apt-get install -y git mysql-server nginx php5-fpm php5-mysql php5-curl

# create guestbook directory
mkdir -vp ${WEB_DIR}
git clone -q https://github.com/dmuth/guestbook.git ${WEB_DIR}

# configure web server 
rm -v /etc/nginx/sites-enabled/*
cp -v /tmp/setup.d/guestbook.nginx /etc/nginx/sites-available/guestbook
ln -vs /etc/nginx/sites-available/guestbook /etc/nginx/sites-enabled/
service nginx restart

# database setup
mysql -u root < "${WEB_DIR}/protected/sql/user.sql"
mysql -u root guestbook < "${WEB_DIR}/protected/sql/schema.sql"

ln -vs "${WEB_DIR}/protected/config/db-production.php" "${WEB_DIR}/protected/config/db.php"

echo "127.0.0.1		guestbook.db" >> /etc/hosts

exit 0

# EOF
