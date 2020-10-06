#!/bin/sh

curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 3.5.0

sysrc -f /etc/rc.conf code_server_enable=YES
sysrc -f /etc/rc.conf nginx_enable=YES

echo "Starting nginx..."
service code_server start
service nginx start