#!/bin/bash
RUN firewall-cmd --permanent --add-port=80/tcp
RUN sudo firewall-cmd --permanent --add-port=443/tcp
RUN sudo firewall-cmd --reload
/usr/sbin/httpd -D FOREGROUND
exec $@

