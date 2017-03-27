FROM php:7-fpm
ENV PATH=/var/www/html:/app/vendor/bin:/root/.composer/vendor/bin:$PATH \
    TERM=xterm-256color \
    ICU_DATA=/opt/icu/icudt52l 

RUN echo "alias composer='sh /root/composer.sh'" >> /root/.bashrc && \ 
    echo "alias yii='sh /root/yii.sh'" >> /root/.bashrc && \
    apt-get update && \
    apt-get install -y libjpeg-dev \
                       libpng12-dev \
                       libfreetype6-dev \
                       libmcrypt-dev \
                       imagemagick \
                       libxml2-dev \
                       libmagickwand-dev \
                       libicu-dev \
                       git \
            --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /opt/icu/icudt52l && \
    curl -o /opt/icu/icudt52l/metaZones.res  \
        http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/metaZones.res && \
    curl -o /opt/icu/icudt52l/timezoneTypes.res \
        http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/timezoneTypes.res && \
    curl -o /opt/icu/icudt52l/windowsZones.res  \ 
        http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/windowsZones.res && \
    curl -o /opt/icu/icudt52l/zoneinfo64.res  \
        http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2016f/44/le/zoneinfo64.res && \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install -j$(nproc) iconv mcrypt && \
    docker-php-ext-install xml && \
    docker-php-ext-install zip && \
    docker-php-ext-install pdo pdo_mysql && \
    docker-php-ext-install exif && \
    docker-php-ext-install soap && \
    docker-php-ext-install intl && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install bcmath && \
    pecl install imagick-3.4.3 && \
    echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini && \
    pecl install timezonedb && docker-php-ext-enable timezonedb

COPY container-files/ /

RUN mv /root/conf/php.ini /usr/local/etc/php 
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
