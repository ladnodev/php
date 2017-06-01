#!/bin/bash
curl -sS https://getcomposer.org/installer | php --
mv composer.phar /usr/local/bin/composer 
runuser - www-data -s /bin/sh -c "/usr/local/bin/php /usr/local/bin/composer config -g github-oauth.github.com ${GITHUB_API_TOKEN}"
runuser - www-data -s /bin/sh -c "/usr/local/bin/php /usr/local/bin/composer config -g bitbucket-oauth.bitbucket.org ${BITBUCKET_CONSUMER_KEY} ${BITBUCKET_CONSUMER_SECRET}"
runuser - www-data -s /bin/sh -c "/usr/local/bin/php /usr/local/bin/composer global require 'fxp/composer-asset-plugin'"
runuser - www-data -s /bin/sh -c "/usr/local/bin/php /usr/local/bin/composer global dumpautoload --optimize"
