FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install curl unzip sudo -y


# Use the official Debian Bullseye base image
FROM debian:bullseye

# Install required dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Download the Portainer binary
RUN curl -L https://github.com/portainer/portainer/releases/download/v2.17.1/portainer-2.17.1-linux-amd64.tar.gz -o /portainer.tar.gz && \
    tar -xzvf /portainer.tar.gz -C / && \
    rm /portainer.tar.gz

# Create a user to run Portainer (security best practice)
RUN useradd -ms /bin/bash portainer

# Set the working directory
WORKDIR /portainer

# Expose the required port
EXPOSE 9000

# Set the entry point to run Portainer
USER portainer
ENTRYPOINT ["/portainer"]

# Command to start Portainer
CMD ["--host", "unix:///var/run/docker.sock"]
