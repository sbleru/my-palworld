#!/bin/bash

## Docker installation
# https://docs.docker.com/engine/install/debian/
# NOTE: This script is executed with root privileges, so sudo is not required.

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

yes | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Start Docker
# see https://github.com/thijsvanloef/palworld-server-docker
sudo useradd -m -u 1002 steam
if [ "$(docker ps -aq -f name=palworld-server)" ]; then
    # If the container exists, start it.
    docker start palworld-server
else
    # If the container does not exist, create a new one.
    docker run -d \
        --name palworld-server \
        -p 8211:8211/udp \
        -p 27015:27015/udp \
        -v /home/steam/palworld:/palworld/ \
        -e PUID=1002 \
        -e PGID=1002 \
        -e PORT=8211 \
        -e PLAYERS=16 \
        -e MULTITHREADING=true \
        -e RCON_ENABLED=true \
        -e RCON_PORT=25575 \
        -e TZ=${tz} \
        -e ADMIN_PASSWORD=${admin_password} \
        -e SERVER_PASSWORD=${server_password} \
        -e COMMUNITY=false \
        -e SERVER_NAME=${server_name} \
        -e SERVER_DESCRIPTION=${server_description} \
        --restart unless-stopped \
        --stop-timeout 30 \
        thijsvanloef/palworld-server-docker:latest
fi
