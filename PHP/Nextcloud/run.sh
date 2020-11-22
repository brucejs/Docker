#!/bin/bash
#
########################################
# Run command for nextcloud
# Globals:
#   REDIS_HOST
#   REDIS_HOST_PASSWORD
# Depends:
#   postgres
#   redis
# Notes:
#   You'll need a front-end proxy to pass requests to this container's
#   port 9000.
########################################
docker container run \
  --detach \
  --env REDIS_HOST="redis" \
  --env REDIS_HOST_PASSWORD="$REDIS_HOST_PASSWORD" \
  --link postgres \
  --link redis \
  --name nextcloud \
  --publish 9000 \
  --restart always \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume /mnt/Nextcloud:/var/www/html/data:rw \
  --volume nextcloud:/var/www/html:rw \
  sharkmoji/nextcloud
