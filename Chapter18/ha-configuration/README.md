# Basic Horizontal Scaling for GitLab with Amazon, Terraform and Ansible

## Requirements
* terraform >= v0.11.12
 * provider.aws v2.1.0
 * provider.tls v1.2.0
* ansible >= 2.7.10 
* jq >= 1.6

## Ansible configuration
Make sure the following is put in your ansible configuration file in /etc or your home directory:

```  
[ssh_connection]
ansible_host_key_checking = False
control_path = %(directory)s/%%C
```  
_There are several options to disable host key checking, but this always works_
_Other options: https://stackoverflow.com/questions/23074412/how-to-set-host-key-checking-false-in-ansible-inventory-file_

``` 
export ANSIBLE_HOST_KEY_CHECKING=false
``` 

## Preparations for deployment

### Initialize the terraform provider and plugins (Amazon and ansible plugin)
terraform init

## Automatic deployment
``` 
./deploy-with-ansible.sh
``` 

## Manual deployment
### Test the terraform configuration
``` 
terraform plan
``` 
### Run the infrastructure deployment
``` 
terraform apply --auto-approve
``` 
## Output the generated private key (please use another location then /tmp if not a demo)
``` 
terraform output  -json|jq .mykey.value -r >/tmp/mykey.pem && chmod 600 /tmp/mykey.pem
``` 
## Provision the Bastion hosts
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install.yml
``` 
## Provision the Postgresql master database
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-master.yml 
``` 
## Provision the Postgresql slave database
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-slaves.yml 
``` 
## Provision the Consul agents
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-consul.yml 
``` 
## Provision the PGBouncer instance
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-pgbouncer.yml
``` 
## Provision the Redis nodes
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-redis.yml
``` 
## Provision the nfs server
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-nfs.yml
``` 
## Provision the GitLab Application hosts
``` 
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-gitlab.yml
 ``` 
