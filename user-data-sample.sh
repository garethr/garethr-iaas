#!/bin/sh
echo "hello world" > /tmp/hello.txt
apt-get update
apt-get install -qy nginx
invoke-rc.d nginx start
echo "Hello from the Brightbox Cloud at `date`" > /var/www/index.html
# Maverick and Lucid use different paths by default
cp /var/www/index.html /var/www/nginx-default/
