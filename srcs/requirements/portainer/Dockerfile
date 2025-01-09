FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install curl unzip sudo -y

RUN rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.21.5/portainer-2.21.5-linux-amd64.tar.gz -o /portainer.tar.gz && \
    tar -xzvf /portainer.tar.gz -C / && \
    rm /portainer.tar.gz

# RUN useradd -ms /bin/bash portainer

WORKDIR /portainer

RUN chmod +x /portainer

EXPOSE 9001

USER root

ENTRYPOINT ["/portainer/portainer"]

CMD ["--host", "unix:///var/run/docker.sock", "--bind", "0.0.0.0:9001"]

# CMD ["sleep", "infinity"]