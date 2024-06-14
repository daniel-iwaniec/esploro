FROM eclipse-temurin:17.0.11_9-jre-jammy
LABEL org.opencontainers.image.source=https://github.com/daniel-iwaniec/esploro

COPY app/app.jar /app/app.jar
COPY --chown=root:root --chmod=744 script /script/

RUN /script/dependencies.sh

WORKDIR /app
USER 1000:1000

ENTRYPOINT ["java", "-jar", "app.jar"]
