resource "ansible_host" "BASTIONHOST_A" {
  inventory_hostname = "${aws_instance.BASTIONHOST_A.public_dns}"
  groups = ["security"]
  vars
  {
      ansible_user = "ubuntu"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "BASTIONHOST_B" {
  inventory_hostname = "${aws_instance.BASTIONHOST_B.public_dns}"
  groups = ["security"]
  vars
  {
      ansible_user = "ubuntu"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "FRONTEND001" {
  inventory_hostname = "${aws_instance.FRONTEND_A.private_dns}"
  groups = ["frontend"]
  vars
  {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-a.cidr_block}"
  }
}

resource "ansible_host" "FRONTEND002" {
  inventory_hostname = "${aws_instance.FRONTEND_B.private_dns}"
  groups = ["frontend"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-b.cidr_block}"
  }
}

resource "ansible_host" "SQL001" {
  inventory_hostname = "${aws_instance.SQL_A.private_dns}"
  groups = ["db"]
  vars
  {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.public-backend-az-a.cidr_block}"
  }
}

resource "ansible_host" "SQL002" {
  inventory_hostname = "${aws_instance.SQL_B.private_dns}"
  groups = ["db"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.public-backend-az-b.cidr_block}"
  }
}

resource "ansible_host" "SQL003" {
  inventory_hostname = "${aws_instance.SQL_C.private_dns}"
  groups = ["db"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.public-backend-az-b.cidr_block}"
  }
}

resource "ansible_host" "REDIS001" {
  inventory_hostname = "${aws_instance.REDIS_A.private_dns}"
  groups = ["redis"]
  vars
  {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
  }
}

resource "ansible_host" "REDIS002" {
  inventory_hostname = "${aws_instance.REDIS_B.private_dns}"
  groups = ["redis"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
  }
}


resource "ansible_host" "CONSUL001" {
  inventory_hostname = "${aws_instance.CONSUL_A.private_dns}"
  groups = ["consul"]
  vars
  {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
  }
}


resource "ansible_host" "CONSUL002" {
  inventory_hostname = "${aws_instance.CONSUL_B.private_dns}"
  groups = ["consul"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
  }
}


resource "ansible_host" "CONSUL003" {
  inventory_hostname = "${aws_instance.CONSUL_C.private_dns}"
  groups = ["consul"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
  }
}

resource "ansible_host" "PGBOUNCER001" {
  inventory_hostname = "${aws_instance.PGBOUNCER_A.private_dns}"
  groups = ["pgbouncer"]
  vars
  {
      ansible_user = "ubuntu"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
  }
}

resource "ansible_host" "NFS001" {
  inventory_hostname = "${aws_instance.NFS_A.private_dns}"
  groups = ["nfs"]
  vars
  {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-a.cidr_block}"
  }
}

resource "ansible_host" "LB001" {
  inventory_hostname = "${aws_elb.lb.dns_name}"
  groups = ["lb"]
  vars
  {
    lb_external_url = "${aws_elb.lb.dns_name}"
  }
}