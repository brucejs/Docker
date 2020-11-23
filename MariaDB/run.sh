#!/bin/bash
#
########################################
# Run command for MariaDB
# Globals:
#   MYSQL_ROOT_PASSWORD
# Depends:
#   None
########################################
HOST=false

while getopts 'h' flag; do
  case "${flag}" in
    h) HOST=true ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

if $HOST; then
  docker container run                               \
    --detach                                         \
    --env MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
    --name mariadb                                   \
    --publish 3306:3306                              \
    --restart always                                 \
    --volume /etc/localtime:/etc/localtime:ro        \
    --volume mariadb:/var/lib/mysql:rw               \
    mariadb:10
else 
  docker container run                               \
    --detach                                         \
    --env MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
    --name mariadb                                   \
    --publish 3306                                   \
    --restart always                                 \
    --volume /etc/localtime:/etc/localtime:ro        \
    --volume mariadb:/var/lib/mysql:rw               \
    mariadb:10
fi
