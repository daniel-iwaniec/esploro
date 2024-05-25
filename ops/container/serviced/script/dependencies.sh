#!/usr/bin/env bash

set -e

apt-get update
apt-get install -y \
        git \
        unzip \
        bash-completion \
        libicu-dev \
        libkrb5-dev \
        libc-client-dev \
        libpq-dev
rm -rf /var/lib/apt/lists/*

pecl install xdebug-3.3.0alpha3
docker-php-ext-enable xdebug

docker-php-ext-configure intl
docker-php-ext-configure pcntl --enable-pcntl
docker-php-ext-install "-j$(nproc)" intl opcache pdo_pgsql pcntl

curl -sS https://get.symfony.com/cli/installer | bash
mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    >&2 echo 'ERROR: Invalid composer installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
rm composer-setup.php
mv composer.phar /usr/bin/composer
