FROM php:7.1-fpm

# use the default production configuration
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Install unzip as persistent dependency. Cachet likes the system one for
# installation and upgrades. Install Supervisor for configuring queue.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends supervisor unzip; \
    mkdir /var/log/supervisord /var/run/supervisord

# install PHP module build dependencies
RUN set -ex; \
    savedAptMark="$(apt-mark showmanual)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      libfreetype6-dev \
      libjpeg-dev \
      libmcrypt-dev \
      libpng-dev \
      libpq-dev \
    ; \
# configure and install modules
    docker-php-ext-configure gd --with-freetype-dir --with-jpeg-dir; \
    docker-php-ext-install -j "$(nproc)" \
      gd \
      mcrypt \
      mysqli \
      pdo_mysql \
      pdo_pgsql \
      pgsql \
    ; \
    pecl install \
      apcu \
      redis-5.3.1 \
    ; \
    docker-php-ext-enable \
      apcu \
      redis \
    ; \
# remove build dependencies and purge apt lists
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
      | awk '/=>/ { print $3 }' \
      | sort -u \
      | xargs -r dpkg-query -S \
      | cut -d: -f1 \
      | sort -u \
      | xargs -rt apt-mark manual; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN set -eux; \
    docker-php-ext-enable opcache; \
    { \
      echo 'opcache.memory_consumption=128'; \
      echo 'opcache.interned_strings_buffer=8'; \
      echo 'opcache.max_accelerated_files=4000'; \
      echo 'opcache.revalidate_freq=2'; \
      echo 'opcache.fast_shutdown=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# give error logging the WordPress treatment
# https://wordpress.org/support/article/editing-wp-config-php/#configure-error-logging
RUN { \
# https://www.php.net/manual/en/errorfunc.constants.php
# https://github.com/docker-library/wordpress/issues/420#issuecomment-517839670
      echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
      echo 'display_errors = Off'; \
      echo 'display_startup_errors = Off'; \
      echo 'log_errors = On'; \
      echo 'error_log = /dev/stderr'; \
      echo 'log_errors_max_len = 1024'; \
      echo 'ignore_repeated_errors = On'; \
      echo 'ignore_repeated_source = Off'; \
      echo 'html_errors = Off'; \
    } > /usr/local/etc/php/conf.d/error-logging.ini

# set custom PHP.ini settings
RUN { \
      echo 'date.timezone=America/Chicago'; \
      echo 'max_execution_time=60'; \
      echo 'post_max_size=32M'; \
      echo 'upload_max_filesize=32M'; \
    } > /usr/local/etc/php/conf.d/custom.ini

# install composer
RUN curl -sS https://getcomposer.org/installer \
      | php -- --install-dir=/usr/local/bin --filename=composer

# copy over cachet-queue supervisor config
COPY cachet.conf /

# start supervisord
CMD ["/usr/bin/supervisord", "-c", "/cachet.conf"]
