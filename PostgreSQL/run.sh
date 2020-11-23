#!/bin/bash
#
########################################
# Run command for PostgreSQL
# Globals:
#   POSTGRES_PASSWORD
# Depends:
#   None
########################################
docker container run                            \
  --detach                                      \
  --env POSTGRES_PASSWORD="$POSTGRES_PASSWORD"  \
  --name postgres                               \
  --publish 5432                                \
  --restart always                              \
  --volume /etc/localtime:/etc/localtime:ro     \
  --volume postgres:/var/lib/postgresql/data:rw \
  postgres:12
