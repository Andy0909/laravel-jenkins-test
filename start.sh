#!/bin/sh

# 清除 Laravel 視圖緩存
php artisan view:clear
php artisan route:clear
php artisan config:clear
php artisan cache:clear

# 啟動 PHP-FPM
php-fpm
