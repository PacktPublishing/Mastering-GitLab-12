#!/bin/bash

#run this script with root permissions (directory or with sudo)

#Create directories first
echo "Creating directories"
mkdir /srv
mkdir /srv/gitlab
mkdir /srv/gitlab/config
mkdir /srv/gitlab/logs
mkdir /srv/gitlab/data

#start container
docker run \
 --hostname gitlab.example.com \
 --publish 443:443 --publish 80:80 --publish 22:22 \
 --name gitlab \
 --volume $HOME/srv/gitlab/config:/etc/gitlab \
 --volume $HOME/srv/gitlab/logs:/var/log/gitlab \
 --volume $HOME/srv/gitlab/data:/var/opt/gitlab \
 gitlab/gitlab-ce:latest
