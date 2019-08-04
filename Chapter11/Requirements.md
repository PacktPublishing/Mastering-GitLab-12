## Requirements 
- A Google Cloud account: https://console.cloud.google.com/start.
- A wildcard DNS entry for your domain (I used kubernetes.joustie.nl) 
- A GitLab instance with internet access

When you have configured a wildcard DNS entry, the AutoDeploy options work (for instance, the host eventmanager.kubernetes.joustie.nl is created in my setup).


## Kubernetes deployment

Make sure you have a kubernetes cluster (1.5+) available. For the book I have used a Google Kubernetes Engine cluster. From within GitLab, you can create the this cluster with the necessary components to be able run a complete DevOps workflow. From the 'Kubernetes' option in the Admin area you have the option to connect a Google Cloud account and create a cluster for you.
How to exactly do this is detailed here : https://docs.gitlab.com/ee/user/project/clusters/index.html

When the cluster is enabled, you can just import the eventmanager repo in your gitlab project and kick off the default pipeline.