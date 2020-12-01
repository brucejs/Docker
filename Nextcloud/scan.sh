#!/bin/bash
#
########################################
# Easily scan for any manually added files
# Globals:
#   None
# Depends:
#   None
########################################
docker container exec nextcloud su www-data -s /bin/sh -c "php /var/www/html/occ files:scan --all"
