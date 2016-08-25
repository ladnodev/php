#!/bin/bash
set -eo pipefail
set -x #DEBUG

DE_UID=1000
DE_GID=1000
DE_TIMEZONE=Europe/Moscow

if [[ ! -f /root/first_start ]]; then
    
    if [[ -z ${DUID} ]]; then
        DUID=${DE_UID}
    fi
    
    if [[ -z ${DGID} ]]; then
        DGID=${DE_GID}
    fi
    
    if [[ -z ${TIMEZONE} ]]; then
        TIMEZONE=${DE_TIMEZONE}
    fi

    #Let's set timezone
    echo "${TIMEZONE}" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata

    #Changing username id
    usermod -u ${DUID} www-data
    groupmod -g ${DGID} www-data

    touch /root/first_start
fi

exec "$@"
