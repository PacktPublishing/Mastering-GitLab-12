#!/bin/bash
# This script creates infrastructure ion AWS and after tha runs ansible jobs on them
# Some scripts are started in a new window to run parallel. It saves time and they run independently.

terraform apply --auto-approve

sleep 120

terraform output  -json|jq .private_key.value -r >/tmp/privkey.pem && chmod 600 /tmp/privkey.pem

export ANSIBLE_HOST_KEY_CHECKING=false
. new_window.sh

ansible-playbook -i /usr/local/bin/terraform.py deploy/install.yml && sleep 120 &&  \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-core.yml  && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-slaves.yml  && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-consul.yml  &&\
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-pgbouncer.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-redis.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-backend-services.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-gitaly.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install-frontend-services.yml 
