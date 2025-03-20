#syntax=docker/dockerfile:1

FROM composer:lts as deps

WORKDIR /app

COPY . .

RUN --mount=type=bind,source=composer.json,target=composer.json \
    --mount=type=bind,source=composer.lock,target=composer.lock \
    --mount=type=cache,target=/tmp/cache \
    composer install --no-dev --no-interaction


#FROM php:8.1-apache as final
FROM php:8.1-cli

RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git \
    && docker-php-ext-install zip sockets \
    && pecl install redis && docker-php-ext-enable redis


RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo_pgsql


RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy application files
COPY . .

RUN composer update --no-dev --no-interaction

# Install PHP dependencies
RUN composer install --no-dev --no-interaction

# Expose port
EXPOSE 8000

# Command to run the application
CMD ["php", "-S", "0.0.0.0:9000", "-t", "public"]

