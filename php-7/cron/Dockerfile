FROM ladno/php:7-fpm
RUN apt-get update && \
    apt-get install -y cron && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY container-files/ /
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cron", "-f"]
