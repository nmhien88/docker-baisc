#!/bin/bash
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/etc/rc.d/init.d/iptables save

/etc/init.d/httpd start
exec $@

