#!/bin/bash

rm -f superscreen
bastion0=`/usr/local/bin/terraform.py| jq '.security.hosts[0]'`
bastion1=`/usr/local/bin/terraform.py| jq '.security.hosts[1]'`
web0=`/usr/local/bin/terraform.py| jq '.web.hosts[0]'`
web1=`/usr/local/bin/terraform.py| jq '.web.hosts[1]'`
db0=`/usr/local/bin/terraform.py| jq '.db.hosts[0]'`
db1=`/usr/local/bin/terraform.py| jq '.db.hosts[1]'`

echo "screen ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem ubuntu@$bastion0 -t \"echo \"PS1=bastion0\"$\"\">>~/.bashrc;bash\" " >superscreen
echo "screen ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem ubuntu@$bastion1 -t \"echo \"PS1=bastion1\"$\"\">>~/.bashrc;bash\" " >> superscreen
echo "screen ssh -i /tmp/privkey.pem ubuntu@$web0 -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem   -W %h:%p -q ubuntu@$bastion0\" -t \"echo \"PS1=web1\"$\"\">>~/.bashrc;bash\"" >>superscreen
echo "screen ssh -i /tmp/privkey.pem ubuntu@$web1 -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem   -W %h:%p -q ubuntu@$bastion1\" -t \"echo \"PS1=web2\"$\"\">>~/.bashrc;bash\"" >>superscreen
echo "screen ssh -i /tmp/privkey.pem ubuntu@$db0 -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem   -W %h:%p -q ubuntu@$bastion0\" -t \"echo \"PS1=db1\"$\"\">>~/.bashrc;bash\"" >>superscreen
echo "screen ssh -i /tmp/privkey.pem ubuntu@$db1 -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem   -W %h:%p -q ubuntu@$bastion1\" -t \"echo \"PS1=db2\"$\"\">>~/.bashrc;bash\"" >>superscreen


