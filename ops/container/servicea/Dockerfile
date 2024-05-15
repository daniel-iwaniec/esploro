FROM node:22.1.0-bookworm AS base
LABEL org.opencontainers.image.source=https://github.com/daniel-iwaniec/esploro

COPY --chown=root:root --chmod=744 script /script/
COPY --chown=1000:1000 --chmod=744 app /app/

RUN /script/dependencies.sh

WORKDIR /app
USER 1000:1000

CMD ["npm", "run", "start:dev"]
