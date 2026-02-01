FROM ubuntu:18.04
LABEL maintener="Eduardo Zenardi"

# Instalar nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80
COPY index.html /var/www/html/

WORKDIR /var/www/html
ENV APP_VERSION=1.0.0


ENTRYPOINT [ "nginx" ]
CMD [ "-g", "daemon off;" ]