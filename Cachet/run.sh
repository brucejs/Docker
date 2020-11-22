#!/bin/bash
#
########################################
# Run command for php-cachet.
# Globals:
#   None
# Depends:
#   postgres
#   redis (optional)
# Notes:
#   You'll need a front-end proxy to pass requests to this container's
#   port 9000.
########################################
docker container run                 \
  --detach                           \
  --link postgres                    \
  --name php-cachet                  \
  --publish 9000                     \
  --restart always                   \
  --volume cachet:/var/www/cachet:rw \
  sharkmoji/php-cachet
