FROM python:3.12.3-bookworm
LABEL org.opencontainers.image.source=https://github.com/daniel-iwaniec/esploro

COPY --chown=root:root --chmod=744 script /script/

RUN /script/dependencies.sh

WORKDIR /app
USER 1000:1000

CMD ["sleep", "infinity"]
