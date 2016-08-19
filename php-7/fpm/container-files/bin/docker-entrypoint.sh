#!/bin/bash
set -eo pipefail
#set -x #DEBUG

DE_VERSION_COMPOSER=1.0.2
DE_GITHUB_API_TOKEN=a47535b398666aed148e8740cbbf445549ee3ba1
DE_TIMEZONE=Europe/Moscow
DE_VERSION_COMPOSER_ASSET_PLUGIN=^1.1.4
DE_UID=1000
DE_GID=1000

#Is it first start?
if [[ ! -f /root/first_start ]]; then

    touch /root/first_start

    #If we don't have variables, then we use default
    if [[ -z ${VERSION_COMPOSER} ]]; then
            VERSION_COMPOSER=${DE_VERSION_COMPOSER}
    fi  
    
    if [[ -z ${GITHUB_API_TOKEN} ]]; then
            GITHUB_API_TOKEN=${DE_GITHUB_API_TOKEN}
    fi  
    
    if [[ -z ${TIMEZONE} ]]; then
            TIMEZONE=${DE_TIMEZONE}
    fi  
    
    if [[ -z ${VERSION_COMPOSER_ASSET_PLUGIN} ]]; then
            VERSION_COMPOSER_ASSET_PLUGIN=${DE_VERSION_COMPOSER_ASSET_PLUGIN}
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

    
    #Composer installation and configuration
    curl -sS https://getcomposer.org/installer | php -- --version=${VERSION_COMPOSER} 
    mv composer.phar /usr/local/bin/composer 
    runuser - www-data -s /bin/sh -c "/usr/local/bin/php /usr/local/bin/composer config -g github-oauth.github.com ${GITHUB_API_TOKEN}"
    runuser - www-data -s /bin/sh -c "/usr/local/bin/php /usr/local/bin/composer global require 'fxp/composer-asset-plugin:${VERSION_COMPOSER_ASSET_PLUGIN}'"
    runuser - www-data -s /bin/sh -c "/usr/local/bin/php /usr/local/bin/composer global dumpautoload --optimize"
    
    
fi

exec "$@"
