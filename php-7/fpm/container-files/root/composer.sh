#!/usr/bin/env bash

arg=$*
su - www-data -s /bin/bash -c "cd /app && composer ${arg}"
