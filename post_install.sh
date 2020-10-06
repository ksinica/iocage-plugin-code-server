#!/bin/sh

#pw user add -n marlena -c 'Marlean Root' -d /home/marlena -G wheel -m -s /usr/local/bin/bash

curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 3.5.0

sysrc -f /etc/rc.conf code_server_enable="YES"
sysrc -f /etc/rc.conf nginx_enable="YES"

service code_server start
service nginx start