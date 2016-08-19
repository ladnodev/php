#!/bin/bash

set -x #DEBUG
set -eo pipefail

DE_TIMEZONE=Europe/Moscow

if [[ ! -f /root/first_run ]]; then
    touch /root/first_run
    if [[ -z $TIMEZONE ]]; then
        TIMEZONE=${DE_TIMEZONE}
    fi
    #Let's set timezone
    echo "${TIMEZONE}" > /etc/timezone 
    dpkg-reconfigure -f noninteractive tzdata
fi

exec "$@"
