#!/bin/sh

curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 3.5.0

sysrc -f /etc/rc.conf code_server_enable="YES"
sysrc -f /etc/rc.conf nginx_enable="YES"

# based on https://nickolaskraus.org/articles/how-to-create-a-self-signed-certificate-for-nginx-on-macos/
mkdir -p /usr/local/etc/ssl/private
mkdir -p /usr/local/etc/ssl/certs
openssl req \
  -x509 -nodes -days 365 -newkey rsa:2048 \
  -subj "/CN=code-server" \
  -keyout /usr/local/etc/ssl/private/self-signed.key \
  -out /usr/local/etc/ssl/certs/self-signed.crt
openssl dhparam -out /usr/local/etc/ssl/certs/dhparam.pem 128


pw user add -n code -m

service code_server start
service nginx start
