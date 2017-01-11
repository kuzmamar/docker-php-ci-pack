FROM php:latest

MAINTAINER Jakub Janata <jakubjanata@gmail.com>

RUN apt-get update && apt-get install -y unzip wget mysql-client postgresql-client

# Install Mysql + Postgre PDO
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql

RUN wget https://getcomposer.org/composer.phar -q \
    && mv composer.phar /usr/local/bin/composer \
    && chmod a+x /usr/local/bin/composer
