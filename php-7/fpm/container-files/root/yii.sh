#!/usr/bin/env bash

arg=$*
su - www-data -s /bin/bash -c "/var/www/html/yii ${arg}"
