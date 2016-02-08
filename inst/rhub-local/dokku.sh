#! /bin/bash

## It should be OK to run this multiple times, the worst that
## can happen is that it updates all software on the machine.

echo "--> Installing dokku"
wget https://raw.githubusercontent.com/dokku/dokku/v0.4.13/bootstrap.sh
sudo cp /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub
sudo DOKKU_TAG=v0.4.13 bash bootstrap.sh

## Configuration

echo ${RHUB_DOMAIN:-rhub.me} > /home/dokku/VHOST
sudo cat /root/.ssh/id_rsa.pub | sshcommand acl-add dokku root

## Plugins

sudo dokku plugin:install https://github.com/dokku/dokku-rabbitmq.git rabbitmq
sudo dokku plugin:install https://github.com/r-hub/dokku-jenkins.git jenkins
