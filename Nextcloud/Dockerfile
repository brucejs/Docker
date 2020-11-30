# custom image with dependencies for all optional Nextcloud features (full)
# https://github.com/nextcloud/docker/tree/master/.examples
FROM nextcloud:20-fpm

# install persistent dependencies
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      libmagickcore-6.q16-6-extra \
      libreoffice \
      procps \
      smbclient \
      supervisor \
    ; \
    rm -rf /var/lib/apt/lists/*

# install PHP module build dependencies
RUN set -ex; \
    savedAptMark="$(apt-mark showmanual)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      libbz2-dev \
      libc-client-dev \
      libkrb5-dev \
      libsmbclient-dev \
    ; \
# configure & install PHP modules
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
    docker-php-ext-install \
      bz2 \
      imap \
    ; \
    pecl install smbclient; \
    docker-php-ext-enable smbclient; \
# remove PHP module build dependencies
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
      | awk '/=>/ { print $3 }' \
      | sort -u \
      | xargs -r dpkg-query -S \
      | cut -d: -f1 \
      | sort -u \
      | xargs -rt apt-mark manual \
    ; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

# create supervisord directory structure
RUN mkdir -p \
    /var/log/supervisord \
    /var/run/supervisord

# copy supervisord config to image
COPY supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
