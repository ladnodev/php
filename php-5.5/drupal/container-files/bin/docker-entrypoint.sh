#!/bin/bash

#set -x #DEBUG
set -eo pipefail

DE_TIMEZONE=Europe/Moscow
DE_UID=1000
DE_GID=1000

if [[ ! -f /root/first_run ]]; then
    touch /root/first_run
    if [[ -z ${TIMEZONE} ]]; then
        TIMEZONE=${DE_TIMEZONE}
    fi
    
    if [[ -z ${DUID} ]]; then
        DUID=${DE_UID}
    fi

    if [[ -z ${DGID} ]]; then
        DGID=${DE_GID}
    fi

    #Let's set timezone
    echo "${TIMEZONE}" > /etc/timezone 
    dpkg-reconfigure -f noninteractive tzdata

    #Let's change uid and git of apache user
    usermod -u ${DUID} www-data
    groupmod -g ${DGID} www-data
fi

exec "$@"
