#!/bin/bash
#
########################################
# Easily flush all keys of all existing databases
# Globals:
#   REDIS_HOST_PASSWORD
# Depends:
#   None
########################################
docker container exec redis redis-cli -a "$REDIS_HOST_PASSWORD" FLUSHALL
