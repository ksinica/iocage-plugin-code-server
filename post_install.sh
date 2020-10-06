#!/bin/sh

curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 3.5.0

sysrc -f /etc/rc.conf nginx_enable=YES

echo "Starting nginx..."
service nginx start