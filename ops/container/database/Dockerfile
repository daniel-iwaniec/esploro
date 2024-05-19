FROM postgres:16.3-bookworm
LABEL org.opencontainers.image.source=https://github.com/daniel-iwaniec/esploro

ENV POSTGRES_USER=root
ENV POSTGRES_PASSWORD=root

COPY sql/initdb.sql /docker-entrypoint-initdb.d/
COPY --chown=root:root --chmod=744 script /script/

RUN /script/configuration.sh

USER 1000:1000
