
## Getting output value from keypair module
terraform  output --module=gitlab_eu.keypair  -json|jq .key_pem.value -r >/tmp/mykey1.pem && chmod 600 /tmp/mykey1.pem
terraform  output --module=gitlab_us.keypair  -json|jq .key_pem.value -r >/tmp/mykey2.pem && chmod 600 /tmp/mykey2.pem

export ANSIBLE_HOST_KEY_CHECKING=false


ssh -o 'ProxyCommand=ssh -o StrictHostKeyChecking=no -i /tmp/mykey1.pem -W %h:%p -q ubuntu@ec2-3-122-253-110.eu-central-1.compute.amazonaws.com'  -i /tmp/mykey1.pem  ubuntu@ec2-3-122-241-128.eu-central-1.compute.amazonaws.com
