# FROM debian:bullseye

# # RUN apt update -y && apt upgrade -y

# # RUN mkdir -p /var/www/html/static

# # COPY ./website-files /var/www/html/static

# # WORKDIR /var/www/html/static

# RUN apt-get update && \
#     apt-get install -y \
#     curl \
#     gnupg2 \
#     lsb-release \
#     ca-certificates
#     # && curl -fsSL https://dl.caddyserver.com | bash -s personal \
#     # && apt-get install -y caddy

# RUN apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
# RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
# RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
# RUN apt update
# RUN apt install caddy

# COPY ./website-files /usr/share/caddy/

# COPY ./Caddyfile /etc/caddy/Caddyfile

# EXPOSE 443

# CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install curl -y

RUN curl -fsSL https://deb.nodesource.com/setup_22.x -o /nodesource_setup.sh && \
    bash /nodesource_setup.sh

RUN apt-get update -y && \
    apt-get install nodejs -y

RUN mkdir -p /var/www/html/static

COPY ./website/* /var/www/html/static

COPY configure.sh /configure.sh

RUN chmod +x /configure.sh

WORKDIR /var/www/html/static

CMD [ "/configure.sh" ]