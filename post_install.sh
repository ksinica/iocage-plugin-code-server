#!/bin/sh

curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 3.5.0

sysrc -f /etc/rc.conf code_server_enable="YES"
sysrc -f /etc/rc.conf nginx_enable="YES"

pw user add -n code -d /home/code -m
mkdir -p /home/code/.config/code-server/
echo "bind-addr: 127.0.0.1:8080" > /home/code/.config/code-server/config.yaml
echo "auth: password" >> /home/code/.config/code-server/config.yaml
echo "password: changeme" >> /home/code/.config/code-server/config.yaml
echo "cert: false" >> /home/code/.config/code-server/config.yaml
chown -R code /home/code/.config

service code_server start
service nginx start