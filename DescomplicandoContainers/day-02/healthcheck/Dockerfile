FROM ubuntu:18.04
LABEL maintener="Eduardo Zenardi"

# Instalar nginx
RUN apt-get update && \
    apt-get install -y nginx curl && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80
ADD https://github.com/prometheus/node_exporter/releases/download/v1.10.2/node_exporter-1.10.2.linux-amd64.tar.gz /root/node-exporter
COPY index.html /var/www/html/

WORKDIR /var/www/html
ENV APP_VERSION=1.0.0


ENTRYPOINT [ "nginx" ]
CMD [ "-g", "daemon off;" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f localhost || exit 1