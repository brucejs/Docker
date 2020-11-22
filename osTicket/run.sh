#!/bin/bash
#
########################################
# Run command for php-osticket.
# Globals:
#   None
# Depends:
#   mariadb
# Notes:
#   You'll need a front-end proxy to pass requests to this container's
#   port 9000.
########################################
docker container run                   \
  --detach                             \
  --link mariadb                       \
  --name php-osticket                  \
  --publish 9000                       \
  --restart always                     \
  --volume cachet:/var/www/osticket:rw \
  sharkmoji/php-osticket
