#!/bin/bash
#
########################################
# Run command for Wiki.js
# Globals:
#   WIKI_DB_PASS
# Depends:
#   postgres
########################################
docker container run                  \
  --detach                            \
  --env DB_HOST="postgres"            \
  --env DB_NAME="wiki"                \
  --env DB_PASS="$WIKI_DB_PASS"       \
  --env DB_PORT=5432                  \
  --env DB_TYPE="postgres"            \
  --env DB_USER="wiki"                \
  --link postgres                     \
  --name wiki                         \
  --publish 3000                      \
  --restart always                    \
  --volume wiki:/wiki/data/content:rw \
  requarks/wiki
