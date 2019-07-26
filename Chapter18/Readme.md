# Files in this directory:
* Readme.md: this file  
* create_directories.sh: script to create volume mappings  
* alertmanager.yml: example configuration file used for the prometheus alertmanager  
* config.toml: a sample configuration file for a GitLab Runner with monitoring enabled  
* prometheus.yml: example configuration file for prometheus server  
* prometheus_edited.yml: example configuration file for prometheus with entry for alertmanager  
  
# Steps to use gitlab runner with metrics enabled and run a prometheus and alertmanager alongside

1. Run the directory creation/copy script
``` 
./create_directories.sh
``` 
2. Make sure you start a runner locally with the following entry in the runner configuration file('config.toml')
``` 
listen_address = ":9252"
```
How to install and run a GitLab runner is subject of Chapter 15 ('Installing and configuring GitLab runners'). An example config.toml file with the correct entry is found in this directory.

3. Start the prometheus docker container (with container name prometheus to reference it and with -d to run as a daemon)
``` 
docker run --name prometheus -d -p 9090:9090 -v ~/srv/prometheus:/etc/prometheus prom/prometheus
```

4. Start a job on the GitLab server

How to do this can be found in Chapter 15 ('Installing and configuring GitLab runners').

5. Open the Prometheus server web-interface
http://localhost:9090

6. Change the Prometheus configuration to enable the Alertmanager

Add the 'alert.rules' as a rule file in the prometheus configuration file (in ~srv/prometheus/prometheus.yml) and add '192.168.178.82:9093' as a target.

Edit the file ~/srv/prometheus/alertmanager.yml and change the emailaddress in the 'receivers' section to the one you want to receive email alerts. Make use you enter an smtp server that accepts email.

7. Start both the Alertmanager and Prometheus docker containers

``` 
docker run -dp 9093:9093 --name=prom_alertmanager -v ~/srv/prometheus/alertmanager.yml:/alertmanager.yml prom/alertmanager --config.file=/alertmanager.yml
docker restart prom_server
``` 
8. Kick off some build jobs and make them fail.

How to create jobs and run them is subject of Chapter 10('Create your product, Verify and Package it').

9. Open the Alertmanager web interface 

http://localhost:9093
You should find new alerts here and also in the email.

# Commands used in Chapter 17

## Restart GitLab Runner with the Homebrew package manager for macOS
``` 
brew services  restart  gitlab-runner
```

## Restart GitLab Runner on other Unix platform
``` 
sudo killall -SIGHUP gitlab-runner
``` 

## Start Prometheus container
``` 
docker run -p 9090:9090  -v ~/srv/prometheus:/etc/prometheus prom/prometheus
``` 

## Start Alertmanager container
``` 
docker run  -dp 9093:9093 --name=prom_alertmanager -v ~/srv/prometheus/alertmanager.yml:/alertmanager.yml prom/alertmanager --config.file=/alertmanager.yml
``` 

## Stop Prometheus container
``` 
docker stop prom_server
``` 

## Remove Prometheus container
``` 
docker rm prom_server
``` 

## Start Prometheus container with Alertmanager enabled
``` 
docker run  -dp 9090:9090 --name=prom_server -v /Users/joostevertse/srv/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml -v ~/srv/prometheus/alert.rules:/etc/prometheus/alert.rules prom/prometheus  --config.file=/etc/prometheus/prometheus.yml
``` 

