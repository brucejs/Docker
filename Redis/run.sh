#!/bin/bash
#
########################################
# Run command for Redis
# Globals:
#   REDIS_HOST_PASSWORD
# Depends:
#   None
########################################
docker container run                        \
  --detach                                  \
  --name redis                              \
  --publish 6379                            \
  --restart always                          \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume redis:/data:rw                   \
  redis:6 redis-server --requirepass "$REDIS_HOST_PASSWORD"
