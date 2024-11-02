# Используем образ PHP с Apache
FROM php:7.4-apache

ARG MARIADB_USER
ENV MARIADB_USER=$MARIADB_USER

# Установка необходимых расширений
RUN apt-get update \
 && apt-get install -y curl libfreetype6-dev libgd-dev libjpeg-dev libpng-dev libzip-dev zip \
 && docker-php-ext-install mysqli \
 && docker-php-ext-enable mysqli \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install gd \
 && apt-get clean
# && rm -r /var/lib/apt/lists/*

# Копируем проект в контейнер
WORKDIR /var/www/html
COPY ./app .
COPY db.php ./config
RUN chown -R www-data:www-data /var/www/html

# Установка Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

# Настройка Apache
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf \
 && a2enmod rewrite

# Запуск Apache
CMD ["apache2-foreground"]
