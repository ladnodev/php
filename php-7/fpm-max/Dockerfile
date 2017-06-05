FROM ladno/php:7-fpm
RUN apt-get update && \
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
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
