#!/bin/bash

WEB_ROOT="/opt/websites"
WEB_DIR="${WEB_ROOT}/guestbook"

SERVER_NAME=`echo $1 | sed s'/.$//'`

# system update and packages install
apt-get update
apt-get upgrade -y
apt-get install -y git nginx php5-fpm php5-mysql php5-curl

# create guestbook directory
mkdir -vp ${WEB_DIR}
git clone -q https://github.com/dmuth/guestbook.git ${WEB_DIR}

# configure web server 
cp -v /tmp/setup.d/guestbook.nginx /etc/nginx/sites-available/guestbook
sed -i "s/__SERVERNAME__/$SERVER_NAME/g" /etc/nginx/sites-available/guestbook 
ln -vs /etc/nginx/sites-available/guestbook /etc/nginx/sites-enabled/
service nginx restart

ln -vs "${WEB_DIR}/protected/config/db-production.php" "${WEB_DIR}/protected/config/db.php"

echo "10.10.10.10		guestbook.db" >> /etc/hosts

exit 0

# EOF
