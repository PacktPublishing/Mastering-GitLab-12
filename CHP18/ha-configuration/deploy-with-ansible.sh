#!/bin/bash

terraform apply --auto-approve

sleep 120

terraform output  -json|jq .private_key.value -r >/tmp/privkey.pem && chmod 600 /tmp/privkey.pem

export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook -i /usr/local/bin/terraform.py deploy/install.yml && sleep 120 &&  \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-core.yml  && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-slaves.yml  && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-consul.yml  && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-pgbouncer.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-redis.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-nfs.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-gitlab.yml 
