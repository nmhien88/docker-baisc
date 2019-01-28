#!/bin/bash

set -e
set -u

echo "Starting ..."
echo 'eval "$(ssh-agent -s)"' > ~/.bashrc

apache2ctl start
php-fpm5.6
