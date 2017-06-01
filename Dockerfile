FROM php:latest

MAINTAINER Jakub Janata <jakubjanata@gmail.com>

RUN apt-get update && apt-get install -y unzip wget mysql-client postgresql-client git

# Install Mysql + Postgre PDO
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql

# Install PHP extensions
RUN docker-php-ext-install zip

RUN wget https://github.com/phpredis/phpredis/archive/develop.zip \
    && unzip develop.zip \
    && cd phpredis-develop \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# Memory Limit
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Install composer
RUN wget https://getcomposer.org/composer.phar -q \
    && mv composer.phar /usr/local/bin/composer \
    && chmod a+x /usr/local/bin/composer \
    && composer --version \
    && composer global require hirak/prestissimo

