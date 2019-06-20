#!/bin/bash


#connect_string="'ProxyCommand=ssh -o StrictHostKeyChecking=no -i /tmp/mykey"  "$3"  ".pem -W %h:%p -q ubuntu@""$1""'" 
#echo $connect_string
#ssh -o $connect_string  -i /tmp/mykey$3.pem  ubuntu@$2

echo 'ProxyCommand=ssh -o StrictHostKeyChecking=no -i /tmp/mykey'$3'.pem -W %h:%p -q ubuntu@'$2''  -i /tmp/mykey$3.pem  ubuntu@$1
ssh -o 'ProxyCommand=ssh -o StrictHostKeyChecking=no -i /tmp/mykey'$3'.pem -W %h:%p -q ubuntu@'$2''  -i /tmp/mykey$3.pem  ubuntu@$1
