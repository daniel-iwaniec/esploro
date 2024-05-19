FROM python:3.12.3-bookworm
LABEL org.opencontainers.image.source=https://github.com/daniel-iwaniec/esploro

COPY --chown=root:root --chmod=744 root-script /root-script/
COPY --chown=1000:1000 --chmod=744 user-script /user-script/

RUN /root-script/dependencies.sh

WORKDIR /app
USER 1000:1000

RUN /user-script/dependencies.sh

CMD ["gunicorn", "-b", "0.0.0.0:80", "serviceb.wsgi:application"]
