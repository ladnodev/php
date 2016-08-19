FROM php:5.6-fpm

# Add configuration files
COPY container-files/ /

ENV PATH=/app:/app/vendor/bin:/root/.composer/vendor/bin:$PATH \
    TERM=xterm-256color \
    ICU_DATA=/opt/icu/icudt52l

# Install system packages for PHP extensions
RUN apt-get update && \
    apt-get -y install \
            git \
            g++ \
            libmcrypt-dev \
            libfreetype6-dev \
            libjpeg-dev \
            libjpeg62-turbo-dev \
            libpng12-dev \
            zlib1g-dev \
            mysql-client \
            openssh-client \
            libxml2-dev \
            libicu-dev \
            nano \
        --no-install-recommends && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Updating ICU timezone data
RUN mkdir -p /opt/icu/icudt52l && \
    curl -o /opt/icu/icudt52l/metaZones.res  http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/metaZones.res && \
    curl -o /opt/icu/icudt52l/timezoneTypes.res  http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/timezoneTypes.res && \
    curl -o /opt/icu/icudt52l/windowsZones.res  http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/windowsZones.res && \
    curl -o /opt/icu/icudt52l/zoneinfo64.res  http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/zoneinfo64.res


# Install PHP extensions required for Yii 2.0 Framework
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-install gd \
                           pdo_mysql \
                           mbstring \
                           mcrypt \
                           zip \
                           pcntl \
                           soap \
                           intl

# Installing Intl dependencies
RUN pecl install timezonedb && docker-php-ext-enable timezonedb

RUN mv /root/conf/php.ini /usr/local/etc/php && \
    echo "alias composer='sh /root/composer.sh'" >> /root/.bashrc && \ 
    echo "alias yii='sh /root/yii.sh'" >> /root/.bashrc 


# Install packages required for Yii 2.0 Framework codeception testing globally
#RUN composer global require  --prefer-dist \
#        "codeception/codeception:${VERSION_CODECEPTION}" \
#        "codeception/specify:*" \
#        "codeception/verify:*" && \
#    composer global dumpautoload --optimize

# Install PECL extensions
# see http://stackoverflow.com/a/8154466/291573) for usage of `printf`
#RUN printf "\n" | pecl install xdebug-2.4.0RC2


# Setup application environment
WORKDIR /app

# Startup script for FPM
#CMD ["/root/run.sh"]

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]

