# 使用 PHP 官方映像作為基底
FROM php:8.3.9-fpm

# 安裝必要的工具和 PHP 擴展
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql zip

# 安裝 Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 安裝 Node.js 和 npm
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

# 設定工作目錄
WORKDIR /var/www

# 複製 Laravel 應用程式內容
COPY . /var/www

# 安裝 Laravel 相依套件
RUN composer install --no-dev --optimize-autoloader --no-scripts

# 安裝 npm 套件
RUN npm install

# 進行前端構建
RUN npm run build

# 設置文件權限
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www/storage
RUN chmod -R 755 /var/www/public

# 清除 Laravel 緩存
RUN php artisan config:cache \
    && php artisan cache:clear \
    && php artisan view:clear \
    && php artisan route:clear

# 印出 public 資料夾裡面的內容
RUN ls -la /var/www/public/css

# 指定容器內的 PHP-FPM 服務為執行入口點
CMD ["php-fpm"]

EXPOSE 9000