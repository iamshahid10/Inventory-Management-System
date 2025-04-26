FROM php:8.1

WORKDIR /app

# Install required system dependencies
RUN apt-get update && apt-get install -y \
  libzip-dev \
  zip \
  git \
  libpq-dev # <-- Install PostgreSQL driver dependencies

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql pgsql

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/bin --filename=composer

# Copy application files
COPY . /app

# Install PHP dependencies
RUN composer install --ignore-platform-reqs

# Give execute permission to startup script
RUN chmod +x /app/docker-startup.sh

# Start the container
ENTRYPOINT [ "/app/docker-startup.sh" ]
