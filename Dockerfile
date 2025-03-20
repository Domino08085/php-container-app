#syntax=docker/dockerfile:1

FROM composer:lts as deps

WORKDIR /app

#COPY . .
COPY composer.json composer.lock ./

RUN composer install --no-dev --no-interaction --prefer-dist --no-scripts --optimize-autoloader

# RUN --mount=type=bind,source=composer.json,target=composer.json \
#     --mount=type=bind,source=composer.lock,target=composer.lock \
#     --mount=type=cache,target=/tmp/cache \
#     composer install --no-dev --no-interaction


#FROM php:8.1-apache as final
FROM php:8.1-cli

RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git libpq-dev \
    && docker-php-ext-install zip sockets pdo_pgsql \
    && pecl install redis && docker-php-ext-enable redis \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# RUN apt-get update && apt-get install -y \
#     libpq-dev \
#     && docker-php-ext-install pdo_pgsql


RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

#COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY --from=deps /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy application files
COPY . .

#RUN composer update --no-dev --no-interaction

# Install PHP dependencies
#RUN composer install --no-dev --no-interaction
RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

# Expose port
EXPOSE 9000

# Command to run the application
CMD ["php", "-S", "0.0.0.0:9000", "-t", "public"]

