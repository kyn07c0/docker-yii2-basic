FROM php:7.4-apache

RUN apt-get update \
 && apt-get install -y curl libfreetype6-dev libgd-dev libjpeg-dev libpng-dev libzip-dev zip \
 && docker-php-ext-install pdo pdo_mysql \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install gd \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

WORKDIR /var/www/html
COPY ./jii2 .
COPY db.php ./config
COPY init_db_jii2.sql ./docker-entrypoint-initdb.d/
RUN chown -R www-data:www-data /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
 && composer install

COPY ./apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf \
 && a2enmod rewrite

CMD ["apache2-foreground"]
