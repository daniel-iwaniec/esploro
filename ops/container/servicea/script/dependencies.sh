#!/usr/bin/env bash

set -e

npm install -g npm@10.7.0

chown -R 1000:1000 /app

echo "alias ll='ls -lah'" >> /home/node/.bash_aliases
