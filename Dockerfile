# Dockerfile - php:8.2-apache with msmtp integration
FROM php:8.2-apache


ENV DEBIAN_FRONTEND=noninteractive


# Install msmtp (msmtp + msmtp-mta provides a sendmail-compatible wrapper) and CA certs
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
msmtp msmtp-mta ca-certificates \
&& rm -rf /var/lib/apt/lists/*


# Set working dir
WORKDIR /var/www/html


# Copy site files into image
COPY web/ /var/www/html/


# Copy msmtp config and php conf
COPY msmtprc /etc/msmtprc
COPY php.ini /usr/local/etc/php/php.ini


# Secure msmtprc (readable by root and www-data) and prepare msmtp log
RUN chmod 640 /etc/msmtprc \
&& chown root:www-data /etc/msmtprc \
&& touch /var/log/msmtp.log \
&& chown www-data:www-data /var/log/msmtp.log


# Ensure web root ownership
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80


# Use the stock Apache foreground command from the base image
