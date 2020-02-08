#!/bin/bash
sudo apt-get -y update


# UPDATE PLUGIN LIST
curl  -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -H  -d @- http://localhost:8080/updateCenter/byId/default/postBack


# INSTALL CLI
sudo cp /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar /var/lib/jenkins/jenkins-cli.jar


# INSTALL PLUGINS
sudo java -jar /var/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 install-plugin ${plugins}

# RESTART JENKINS TO ACTIVATE PLUGINS
sudo java -jar /var/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 restart


sudo service jenkins restart
