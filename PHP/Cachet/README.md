# php-cachet

Custom PHP image based upon php:7.1-fpm for running [Cachet v2.3.18](https://github.com/CachetHQ/Cachet/tree/v2.3.18).

Required PHP modules:

- apcu
- gd
- mcrypt
- mysqli
- pdo_mysql
- pdo_pgsql
- pdo_sqlite<sup>\*</sup>
- pgsql
- redis
- simplexml<sup>\*</sup>
- sqlite3<sup>\*</sup>
- tokenizer<sup>\*</sup>
- xml<sup>\*</sup>

<sup>\* already included in php:7.1-fpm</sup>

## Installation

1. Prepare your database and start sharkmoji/php-cachet

2. Download and unpack latest pinned version:

```
wget https://github.com/CachetHQ/Cachet/archive/v2.3.18.tar.gz
tar xf v2.3.18.tar.gz
cd Cachet-2.3.18
```

3. Copy `.env.example` to `.env` and edit for your environment. Leave `APP_KEY` variable alone for now.

4. Copy source files to container:

```
sudo docker container cp . php-cachet:/var/www/cachet
```

5. Drop into container and fix ownership/permissions:

```
sudo docker container exec -it php-cachet sh
chown -R www-data:www-data /var/www/cachet
find /var/www/cachet -type d -exec chmod 775 {} \;
find /var/www/cachet -type f -exec chmod 664 {} \;
```

6. Substitute user and complete installation:

```
su - www-data -s /bin/sh
composer install --no-dev -o
php artisan key:generate
php artisan app:install
```

7. Visit your `APP_URL` in a web browser and complete configuration.
