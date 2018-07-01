FROM php:7.2-apache
LABEL maintainer "Armand Abric <armand@forgebinaire.net>"

ARG SELFOSS_VERSION

# selfoss requirements: mod-headers, mod-rewrite, gd
RUN a2enmod headers rewrite && \
    apt-get update && \
    apt-get install -y unzip libjpeg62-turbo-dev libpng-dev libpq-dev && \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd mbstring pdo_pgsql pdo_mysql

ADD https://github.com/SSilence/selfoss/releases/download/${SELFOSS_VERSION}/selfoss-${SELFOSS_VERSION}.zip /tmp/

RUN unzip /tmp/selfoss-*.zip -d /var/www/html && \
    rm /tmp/selfoss-*.zip && \
    ln -s /var/www/html/data/config.ini /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Extend maximum execution time, so /refresh does not time out
COPY php.d/max-execution-time.ini /usr/local/etc/php/conf.d/

VOLUME /var/www/html/data
