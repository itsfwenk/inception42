FROM debian:bullseye

ARG FTP_USER

ARG FTP_PASSWORD

RUN apt update -y && apt upgrade -y && apt install vsftpd -y

RUN useradd -m -d /web_data -G www-data ${FTP_USER}

RUN chown -R www-data:www-data /web_data

RUN echo ${FTP_USER}:${FTP_PASSWORD} | chpasswd

RUN mkdir -p /var/run/vsftpd/empty

RUN mkdir -p /wed_data && chmod 775 /web_data

COPY vsftpd.conf /etc/vsftpd.conf

EXPOSE 20 21 30000-30100

CMD ["usr/sbin/vsftpd", "/etc/vsftpd.conf"]