FROM php:7-fpm

RUN apt-get update && \
    apt-get install -y cron && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY container-files/ /

COPY container-files/ /

RUN mv /root/conf/supervisord.conf /etc/supervisor/conf.d

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-n"]