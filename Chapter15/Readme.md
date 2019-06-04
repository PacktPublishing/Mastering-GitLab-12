
# Files in this directory:
Readme.md - this file 

Dockerfile - dockerfile example used in this chapter


# Commands used in Chapter 15

## Build the container with the following command
``` 
docker build --no-cache -t <name of docker image to build> . 
``` 

## Command to display installed Docker images on the system
``` 
dokcer images
``` 

## Run a Docker image
``` 
docker run -ti <name of runner image to run>
```

## Run the GitLab Runner Docker image with drive mappings
``` 
docker run -d --name gitlab-runner -v /Users/shared/gitlab-runner/config:/etc/gitlab-runner \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gitlab/gitlab-runner:latest
    ``` 

## View the standard output of a container 
``` 
dockers logs -f <name of running container>
``` 

## Install gitlab-runner Helm chart into cluster
``` 
helm install --namespace gitlab --name gitlabrunner -f values.yaml  gitlab/gitlab-runner
```

## View list of Kubernetes pods in the cluster
``` 
kubectl get pods -n gitlab
``` 
