#!/bin/sh

sleep 10s

# Setup commands
php artisan key:generate
php artisan migrate --seed
php artisan storage:link

# Serve from the "public" directory so static files (CSS, JS, images) work properly
php -S 0.0.0.0:8080 -t public
