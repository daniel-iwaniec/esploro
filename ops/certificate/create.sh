#!/usr/bin/env bash

set -e
cd "${0%/*}"
TYPE=none

while getopts ":t:" OPTKEY; do
    case "$OPTKEY" in
        t) TYPE=${OPTARG};;
        :) echo "MISSING ARGUMENT for option -- ${OPTKEY}" >&2
           exit 1;;
        ?) echo "INVALID OPTION -- ${OPTARG}" >&2
           exit 1;;
    esac
done

if ! [[ "$TYPE" =~ ^(c|ca|none)$ ]]; then
  echo "Provide type to create: c (certificate) or ca (certificate authority)"
  exit 1
fi

if [ "$TYPE" == "ca" ]; then
  rm -f ca.key
  rm -f ca.crt

  openssl genrsa -out ca.key 4096
  openssl req -new -x509 -days 3650 -config ca.cnf -key ca.key -out ca.crt
fi

if [[ "$TYPE" =~ ^(c|none)$ ]]; then
  rm -f esploro.key
  rm -f esploro.csr
  rm -f esploro.crt

  openssl genrsa -out esploro.key 2048
  openssl req -new -nodes -key esploro.key -config esploro.cnf -out esploro.csr
  openssl x509 -req -in esploro.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
          -out esploro.crt -days 1024 -sha256 -extfile esploro.cnf -extensions req_ext
fi
