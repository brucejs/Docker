#!/bin/bash
#
########################################
# Run command for MariaDB
# Globals:
#   MYSQL_ROOT_PASSWORD
########################################
docker container run                               \
  --detach                                         \
  --env MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
  --name mariadb                                   \
  --publish 3306                                   \
  --restart always                                 \
  --volume /etc/localtime:ro                       \
  --volume mariadb:/var/lib/mysql                  \
  mariadb:10
