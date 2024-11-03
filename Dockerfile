FROM php:7.4-apache

RUN apt-get update \
 && apt-get install -y curl libfreetype6-dev libgd-dev libjpeg-dev libpng-dev libzip-dev zip \
 && docker-php-ext-install pdo pdo_mysql \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install gd \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

WORKDIR /var/www/html
COPY ./app .
COPY db.php ./config
RUN chown -R www-data:www-data /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

COPY ./apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf \
 && a2enmod rewrite

CMD ["apache2-foreground"]
