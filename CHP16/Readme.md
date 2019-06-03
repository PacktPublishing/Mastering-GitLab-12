
# Files in this directory:
Readme.md - this file 

config.toml- a sample configuration file for a GitLab Runner 

# Commands used in Chapter 16

## Install GitLab Runner with the Homebrew package manager for macOS
``` 
brew install gitlab-runner
```

## Register the GitLab Runner instance with GitLab
``` 
gitlab-runner register
``` 

## Check the version of the Docker-machine binary
``` 
docker-machine -v
``` 

## Download the latest version of the Docker-machine binary
``` 
wget -q https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-Linux-x86_64 -O /usr/bin/docker-machine && \
     chmod +x /usr/bin/docker-machine
``` 

## Start the Docker registry container with a port mapping form 6000:5000
``` 
docker run -d -p 6000:5000 -e REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io  --name runner-registry registry:2
``` 

## Access the standard output of the container called 'registry'
``` 
docker logs registry -f
``` 

## Start the local Minio S3 object store and name it 'caching-server' and map port 9005:9000 
``` 
docker run -it -p 9005:9000 -v ~/.minio:/root/.minio -v /s3:/export --name caching-server minio/minio:latest server /export
``` 

## Start the GitLab Runner using the Homebrew package manager
``` 
brew services start gitlab-runner
``` 

## Change the context to a different Docker engine to control. In this case the vm runner-fatr91wm-elastic-runner-1558647049-87941946
``` 
eval $(docker-machine env runner-fatr91wm-elastic-runner-1558647049-87941946)
``` 

## Get a list of vm's in control of docker-machine
``` 
docker-machine ls
``` 

