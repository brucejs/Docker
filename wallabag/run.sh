#!/bin/bash
#
########################################
# Run command for wallabag
# Globals:
#   None
# Depends:
#   mariadb
#   postgres (optional)
#   rabbitmq (optional)
#   redis (optional)
# Notes:
#   You'll need a front-end proxy to pass requests to this container's
#   port 9000.
########################################
docker container run                        \
  --detach                                  \
  --link mariadb                            \
  --name wallabag                           \
  --publish 9000                            \
  --restart always                          \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume wallabag:/var/www/wallabag:rw    \
  sharkmoji/wallabag
