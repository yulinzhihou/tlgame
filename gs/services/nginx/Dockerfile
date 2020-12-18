FROM creativitykills/nginx-php-server:latest

RUN rm -rf /etc/nginx/sites-available/default.conf
COPY ./init.d/default.conf /etc/nginx/sites-available/default.conf

WORKDIR /home/www/
