Files in this directory:

``` 
.
├── DAST
│   └── .gitlab-ci.yml    #Config file to run a Dynamic Application Security test in your project
├── README.md
├── SAST
│   └── .gitlab-ci.yml    #Config file to run a Static Application Security test in your project
├── dependency-scanning
│   └── .gitlab-ci.yml    #Config file to run a dependency test in your project
├── gitlab-monitor          Two files to enable Prometheus to scape the GitLab Monitor exorter
│   ├── gitlab_metrics_exporter_sd.yml 
│   └── prometheus.yml
└── python-exporter       
    ├── prometheus.yml     #Prometheus configuration which scrapes port 8000
    └── sample_exporter.py  #Sample Python exporter which exposes metrics on port 8000 when run
``` 


# Commands used in chapter 11

## Starting a prometheus Docker Container
``` 
 docker run -it --name my-prometheus \
 -v /tmp:/etc/prometheus \
 --publish 9090:9090 \
 prom/prometheus
 ``` 
 