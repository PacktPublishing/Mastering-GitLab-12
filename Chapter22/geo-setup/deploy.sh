#!/bin/bash

terraform apply --auto-approve

terraform  output --module=gitlab_eu.keypair  -json|jq .key_pem.value -r >/tmp/mykey1.pem && chmod 600 /tmp/mykey1.pem
terraform  output --module=gitlab_us.keypair  -json|jq .key_pem.value -r >/tmp/mykey2.pem && chmod 600 /tmp/mykey2.pem

export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook -i /usr/local/bin/terraform.py deploy/install_bastionhost.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install_gitlab_primary.yml && \
ansible-playbook -i /usr/local/bin/terraform.py deploy/install_gitlab_secondary.yml && \
ansible-playbook -vvv  -i /usr/local/bin/terraform.py deploy/configure_replication.yml
