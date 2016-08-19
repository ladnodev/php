#!/bin/bash
set -eo pipefail
set -x #DEBUG

DE_VERSION_COMPOSER=1.0.2
DE_VERSION_COMPOSER_ASSET_PLUGIN=^1.1.4
DE_VERSION_PRESTISSIMO_PLUGIN=^0.1.18
DE_VERSION_CODECEPTION=^2.1.7
DE_UID=1000
DE_GID=1000
DE_GITHUB_API_TOKEN=e97e5a0d1b5433a582f6a1b2b95f9dd3cbe183aa
DE_TIMEZONE=Europe/Moscow

if [[ ! -f /root/first_start ]]; then
    if [[ -z ${VERSION_COMPOSER} ]]; then
        VERSION_COMPOSER=${DE_VERSION_COMPOSER}
    fi
    
    if [[ -z ${VERSION_COMPOSER_ASSET_PLUGIN} ]]; then
        VERSION_COMPOSER_ASSET_PLUGIN=${DE_VERSION_COMPOSER_ASSET_PLUGIN}
    fi
    
    if [[ -z ${VERSION_PRESTISSIMO_PLUGIN} ]]; then
        VERSION_PRESTISSIMO_PLUGIN=${DE_VERSION_PRESTISSIMO_PLUGIN}
    fi
    
    if [[ -z ${VERSION_CODECEPTION} ]]; then
        VERSION_CODECEPTION=${DE_VERSION_CODECEPTION}
    fi
    
    if [[ -z ${DUID} ]]; then
        DUID=${DE_UID}
    fi
    
    if [[ -z ${DGID} ]]; then
        DGID=${DE_GID}
    fi
    
    if [[ -z ${GITHUB_API_TOKEN} ]]; then
        GITHUB_API_TOKEN=${DE_GITHUB_API_TOKEN}
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

    #Install Composer
    chown -R www-data:www-data /var/www 
    curl -sS https://getcomposer.org/installer | php -- --version=${VERSION_COMPOSER} 
    mv composer.phar /usr/local/bin/composer 
    su - www-data -s /bin/bash -c "composer config -g github-oauth.github.com ${GITHUB_API_TOKEN}"
    su - www-data -s /bin/bash -c "composer global require \
        fxp/composer-asset-plugin:${VERSION_COMPOSER_ASSET_PLUGIN} \
        hirak/prestissimo:${VERSION_PRESTISSIMO_PLUGIN}"
    su - www-data -s /bin/bash -c "composer global dumpautoload --optimize"
    touch /root/first_start
fi

exec "$@"
