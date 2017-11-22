FROM ladno/php:7-fpm
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y nano \
                       ffmpeg \
            --no-install-recommends
RUN apt-get update && \
    apt-get install -y autoconf g++ make openssl libssl-dev libcurl4-openssl-dev && \
    apt-get install -y libcurl4-openssl-dev pkg-config && \
    apt-get install -y libsasl2-dev && \
    pecl install mongodb && \
    echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/ext-mongo.ini && \
    apt-get purge -y --auto-remove libssl-dev

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    apt-get update && \
    apt-get install nodejs && \
    apt-get install build-essential && \
    npm install npm@latest -g &&  \
    npm install -g less 

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
