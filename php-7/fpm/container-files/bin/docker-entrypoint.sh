#!/bin/bash
set -eo pipefail
#set -x #DEBUG

#Is it first start?
if [[ ! -f /root/first_start ]]; then
    touch /root/first_start
    
fi

DE_TIMEZONE=Europe/Moscow
DE_UID=1000
DE_GID=1000
    
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

#Let's change UID and GID for www-data
usermod -u ${DUID} www-data 
groupmod -g ${DGID} www-data 
chown www-data.www-data /var/www

DOCKERHOST=`/sbin/ip route|awk '/default/ { print $3 }'`
echo "${DOCKERHOST}  dockerhost" >> /etc/hosts

exec "$@"
