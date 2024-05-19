#!/usr/bin/env bash

set -e

addgroup -q --gid 1000 esploro
adduser -q --uid 1000 --gid 1000 esploro

mkdir -p /var/lib/postgresql
mkdir -p /var/run/postgresql

chown -R 1000:1000 /var/lib/postgresql
chown -R 1000:1000 /var/run/postgresql

echo "alias ll='ls -lah'" >> /home/esploro/.bash_aliases
