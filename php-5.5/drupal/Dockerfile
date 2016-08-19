FROM php:5.5-apache
RUN apt-get update && \
    apt-get install -y libjpeg-dev \
                       libpng12-dev \
                       libfreetype6-dev \
                       php5-mysql \
                       libmcrypt-dev \
                       imagemagick \
                       libxml2-dev \
                       gsfonts \
                       libmagickwand-dev \
        --no-install-recommends && rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ && \
    docker-php-ext-configure mysql && \
    docker-php-ext-install gd && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install mysql && \
    docker-php-ext-install -j$(nproc) iconv mcrypt && \
    docker-php-ext-install xml && \
    docker-php-ext-install zip && \
    docker-php-ext-install pdo pdo_mysql && \
    docker-php-ext-install exif && \
    pecl install imagick-beta && \
    echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini && \
    a2enmod rewrite
COPY container-files/ /
RUN mv /root/conf/php.ini /usr/local/etc/php
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
