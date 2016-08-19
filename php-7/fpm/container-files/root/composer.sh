#!/usr/bin/env bash

arg=$*
su - www-data -s /bin/bash -c "cd /var/www/html && composer ${arg}"
