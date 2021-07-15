FROM php:7.3.6-fpm-alpine3.9

RUN apk add --no-cache shadow openssl bash mysql-client nodejs npm git
RUN docker-php-ext-install pdo pdo_mysql

RUN touch /home/www-data/.bashrc | echo "PS1='\w\$ '" >> /home/www-data/.bashrc

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 539210745 www-data

RUN usermod --non-unique --uid 539210745 www-data \
  && groupmod --non-unique --gid 539210745 www-data \
  && chown -R www-data:www-data /var/www

WORKDIR /var/www
RUN chown -R 777 /var/*

RUN rm -rf /var/www/html && ln -s public html

USER www-data

EXPOSE 9000
