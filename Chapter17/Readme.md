
# Files in this directory:
Readme.md - this file 

config.toml- a sample configuration file for a GitLab Runner with monitoring enabled

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
docker run -p 9090:9090 -v ~/srv/prometheus:/etc/prometheus prom/prometheus
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

