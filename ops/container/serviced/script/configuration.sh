#!/usr/bin/env bash

set -e

mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
mv /configuration/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
mv /configuration/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
mv /configuration/openssl.ini /usr/local/etc/php/conf.d/openssl.ini
mv /configuration/ca.pem /usr/local/etc/ca.pem

sed -i 's/user = www-data/;user=/' /usr/local/etc/php-fpm.d/www.conf
sed -i 's/group = www-data/;group=/' /usr/local/etc/php-fpm.d/www.conf

addgroup --gid 1000 esploro
adduser --home /home/esploro/ --uid 1000 --gid 1000 esploro

chown -R 1000:1000 /app

echo "alias ll='ls -lah'" >> /home/esploro/.bash_aliases
# shellcheck disable=SC2129
echo "source /script/completion.sh" >> /home/esploro/.bashrc
# shellcheck disable=SC2016
echo 'PATH="${PATH}:/app/vendor/bin:/app/bin"' >> /home/esploro/.bashrc
