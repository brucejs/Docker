#! /bin/bash
#
########################################
# Run command for TiddlyWiki
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
  brucejs/tiddlywiki
