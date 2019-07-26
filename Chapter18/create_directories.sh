#!/bin/bash

#create directories if they do not exist
mkdir -p ~/srv/
mkdir -p ~/srv/prometheus

#copy config files for prometheus and alertmanager
cp *.yml ~/srv/prometheus/

#copy prometheus rule file
cp *.rules ~/srv/prometheus/


