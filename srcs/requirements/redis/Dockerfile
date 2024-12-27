FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install redis -y

EXPOSE 6379

CMD ["redis-server", "--bind", "0.0.0.0", "--protected-mode", "no"]