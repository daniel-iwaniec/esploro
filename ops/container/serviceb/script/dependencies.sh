#!/usr/bin/env bash

set -e

addgroup -q --gid 1000 python
adduser -q --uid 1000 --ingroup python python

install -o 1000 -g 1000 -m 744 -d /app

echo "alias ll='ls -lah'" >> /home/python/.bash_aliases
