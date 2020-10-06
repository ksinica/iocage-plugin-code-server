#!/bin/sh

curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 3.5.0

sysrc -f /etc/rc.conf code_server_enable="YES"
sysrc -f /etc/rc.conf nginx_enable="YES"

mkdir -p /root/.config/code-server/
echo "bind-addr: 127.0.0.1:8080" > /root/.config/code-server/config.yaml
echo "auth: password" >> /root/.config/code-server/config.yaml
echo "password: changeme" >> /root/.config/code-server/config.yaml
echo "cert: false" >> /root/.config/code-server/config.yaml

service code_server start
service nginx start