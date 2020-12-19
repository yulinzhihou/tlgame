FROM creativitykills/nginx-php-server:latest

RUN mv /etc/nginx/sites-available/default.conf /etc/nginx/sites-available/default.conf_bak
COPY ./init.d/default.conf /etc/nginx/sites-available/default.conf

WORKDIR /var/www/
