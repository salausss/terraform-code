#!/bin/bash

apt-get update
apt-get install apache2 -y

systemctl enable apache2
systemctl start apache2

cat << EOF > /var/www/index.html
This is test page created from EOF syntax
EOF