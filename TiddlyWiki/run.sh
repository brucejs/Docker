#! /bin/bash
#
########################################
# Run command for tiddlywiki
# Globals:
#   None
# Depends:
#   None
########################################
docker container run                        \
  --detach                                  \
  --name tiddlywiki                         \
  --publish 8080                            \
  --restart always                          \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume tiddlywiki:/wiki:rw              \
  sharkmoji/tiddlywiki
