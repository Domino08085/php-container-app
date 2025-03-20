#syntax=docker/dockerfile:1

FROM composer:lts as deps

WORKDIR /app

#COPY . .
COPY composer.json composer.lock ./


#FROM php:8.1-apache as final
FROM php:8.1-cli

RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git libpq-dev \
    && docker-php-ext-install zip sockets pdo_pgsql \
    && pecl install redis && docker-php-ext-enable redis \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install RoadRunner binary
RUN curl -Ls https://github.com/roadrunner-server/roadrunner/releases/latest/download/roadrunner-linux-amd64 -o /usr/local/bin/rr \
    && chmod +x /usr/local/bin/rr


RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy application files
WORKDIR /var/www/html
COPY . .

#COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY --from=deps /usr/bin/composer /usr/bin/composer

#RUN composer update --no-dev --no-interaction --with-all-dependencies

RUN composer install --no-dev --no-interaction --prefer-dist --no-scripts --optimize-autoloader 

# Expose port
EXPOSE 9000

# Command to run the application
CMD ["php", "-S", "0.0.0.0:9000", "-t", "public"]
#CMD ["rr", "serve", "-c", ".rr.yaml"]
