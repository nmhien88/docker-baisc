#!/bin/bash
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload
/usr/sbin/httpd -D FOREGROUND
exec $@

