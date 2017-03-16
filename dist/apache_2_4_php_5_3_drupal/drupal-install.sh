#!/usr/env/bin bash

set -e

DRUPAL_CORE_DEPS="libpng-dev \
    libjpeg-dev \
    libmysqlclient-dev \
    libmcrypt-dev"

DRUPAL_CORE_BUILD_DEPS="autoconf \
    file \
    g++ \
    gcc \
    pkgconf \
    re2c"

apt-get update \
    && apt-get -y install --no-install-recommends \
    $DRUPAL_DEPS \
    $DRUPAL_BUILD_DEPS \
    $DRUPAL_CORE_DEPS \
    $DRUPAL_CORE_BUILD_DEPS

docker-php-ext-get
docker-php-ext-install gd --with-jpeg-dir --with-png-dir
docker-php-ext-install opcache
docker-php-ext-install pdo_mysql
docker-php-ext-install zip
docker-php-ext-install mcrypt
docker-php-ext-remove

apt-get -y remove --purge \
    $DRUPAL_BUILD_DEPS \
    $DRUPAL_CORE_BUILD_DEPS \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/
