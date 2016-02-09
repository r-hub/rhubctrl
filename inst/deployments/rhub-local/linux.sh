#! /bin/bash

if ! command -v docker >/dev/null; then
    echo "--> Installing docker"
    wget -nv -O - https://get.docker.com/ | sh
    sudo adduser vagrant docker
fi

if ! dpkg -l | grep -q default-jre; then
    echo "--> Installing java"
    sudo apt-get install -y -q --no-install-recommends default-jre
fi

if ! [ -e swarm-client.jar ]; then
    echo "--> Downloading Jenkins SWARM client"
    wget -q -O swarm-client.jar.bak \
	 http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar
    mv swarm-client.jar.bak swarm-client
fi

## Start the swarm client as an upstart service
## We cannot copy the config file directly to /etc/init
## because the 'file' provisioner runs as an ordinary
## vagrant user, not root, while this 'shell' provisioner
## runs as root
cp swarm.conf /etc/init/
stop swarm
start swarm JENKINS_PASSWORD=$JENKINS_PASSWORD RHUB_IP=$RHUB_IP
