#!/bin/bash
#
########################################
# Run command for osTicket
# Globals:
#   None
# Depends:
#   mariadb
# Notes:
#   You'll need a front-end proxy to pass requests to this container's
#   port 9000.
########################################
docker container run                        \
  --detach                                  \
  --link mariadb                            \
  --name osticket                           \
  --publish 9000                            \
  --restart always                          \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume osticket:/var/www/osticket:rw    \
  sharkmoji/osticket
