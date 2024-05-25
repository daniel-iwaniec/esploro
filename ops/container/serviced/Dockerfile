FROM php:8.3.7-fpm-bookworm
LABEL org.opencontainers.image.source=https://github.com/daniel-iwaniec/esploro

COPY --chown=root:root --chmod=644 configuration /configuration/
COPY --chown=root:root --chmod=744 script /script/

WORKDIR /app

RUN /script/dependencies.sh && \
    /script/configuration.sh

USER 1000:1000
