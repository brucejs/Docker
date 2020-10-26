#! /bin/bash
#
########################################
# Run command for Syncthing
# Globals:
#   FQDN
# Depends:
#   None
# Arguments:
#   -f   if present, use full DNS hostname (FQDN) of host machine for container
# Notes:
#   Publish port 8384 but don't bind to the host. I prefer to proxy http
#   requests with NGINX.
########################################
FQDN=false

while getopts 'f' flag; do
  case "${flag}" in
    f) FQDN=true ;;
  esac
done

if $FQDN; then
  docker container run                     \
    --detach                               \
    --hostname $(hostname --fqdn)          \
    --name syncthing                       \
    --publish 22000:22000                  \
    --publish 8384                         \
    --restart always                       \
    --volume syncthing:/var/syncthing:rw   \
    --volume ~/Sync:/var/syncthing/Sync:rw \
    syncthing/syncthing
else
  docker container run                     \
    --detach                               \
    --hostname $(hostname)                 \
    --name syncthing                       \
    --publish 22000:22000                  \
    --publish 8384                         \
    --restart always                       \
    --volume syncthing:/var/syncthing:rw   \
    --volume ~/Sync:/var/syncthing/Sync:rw \
    syncthing/syncthing
fi
