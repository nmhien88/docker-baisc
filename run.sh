#!/bin/bash
/sbin/iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
/etc/init.d/iptables save

/etc/init.d/httpd start
exec $@

