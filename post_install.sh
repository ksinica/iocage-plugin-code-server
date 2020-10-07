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
  -keyout /usr/local/etc/ssl/private/cakey.pem \
  -out /usr/local/etc/ssl/certs/cacert.crt
openssl dhparam -out /usr/local/etc/ssl/certs/dhparam.pem 2048

pw user add -n coder -m

service code_server start
service nginx start

sleep 5

echo "Password: $(pluginget password)" > /root/PLUGIN_INFO
echo "Certificate: $(openssl x509 -in /usr/local/etc/ssl/certs/cacert.crt -noout -text)" >> /root/PLUGIN_INFO