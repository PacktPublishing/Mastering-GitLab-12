# A new iteration of Horizontal Scaling for GitLab with Amazon, Terraform and Ansible

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

### Terraform setup
```
terraform init
```


## Automatic deployment
``` 
./deploy-with-ansible.sh
``` 

