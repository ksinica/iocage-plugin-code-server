#!/bin/sh

curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 3.5.0

sysrc -f /etc/rc.conf code_server_enable="YES"
sysrc -f /etc/rc.conf nginx_enable="YES"

pw user add -n code -m

service code_server start
service nginx start