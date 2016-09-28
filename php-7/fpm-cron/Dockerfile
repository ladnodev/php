FROM php:7-fpm

RUN apt-get update && \
    apt-get install -y cron && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY container-files/supervisord.conf /etc/supervisor/conf.d/default.conf

CMD ["/usr/bin/supervisord", "-n"]