resource "ansible_host" "BASTIONHOSTA" {
  inventory_hostname = "${aws_instance.BASTIONHOSTA.public_dns}"
  groups = ["security"]
  vars = {
      ansible_user = "ubuntu"
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "BASTIONHOSTB" {
  inventory_hostname = "${aws_instance.BASTIONHOSTB.public_dns}"
  groups = ["security"]
  vars = {
      ansible_user = "ubuntu"
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "FRONTEND001" {
  inventory_hostname = "${aws_instance.FRONTENDA.private_dns}"
  groups = ["frontend"]
  vars = {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTA.public_dns}\""
      proxy = "${aws_instance.BASTIONHOSTA.private_ip}"
      subnet = "${aws_subnet.pub-web-az-a.cidr_block}"
  }
}

resource "ansible_host" "FRONTEND002" {
  inventory_hostname = "${aws_instance.FRONTENDB.private_dns}"
  groups = ["frontend"]
  vars = {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTB.public_dns}\""
      proxy = "${aws_instance.BASTIONHOSTB.private_ip}"
      subnet = "${aws_subnet.pub-web-az-b.cidr_block}"
  }
}


resource "ansible_host" "BACKEND002" {
  inventory_hostname = "${aws_instance.BACKENDB.private_dns}"
  groups = ["backend"]
  vars = {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTB.public_dns}\""
      proxy = "${aws_instance.BASTIONHOSTB.private_ip}"
      subnet = "${aws_subnet.pub-web-az-b.cidr_block}"
  }
}

resource "ansible_host" "BACKEND001" {
  inventory_hostname = "${aws_instance.BACKENDA.private_dns}"
  groups = ["backend"]
  vars = {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTA.public_dns}\""
      proxy = "${aws_instance.BASTIONHOSTA.private_ip}"
      subnet = "${aws_subnet.pub-web-az-a.cidr_block}"
  }
}

resource "ansible_host" "SQL001" {
  inventory_hostname = "${aws_instance.SQLA.private_dns}"
  groups = ["db"]
  vars = {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTA.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTA.private_ip}"
      subnet = "${aws_subnet.priv-db-az-a.cidr_block}"
  }
}

resource "ansible_host" "SQL002" {
  inventory_hostname = "${aws_instance.SQLB.private_dns}"
  groups = ["db"]
  vars = {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTB.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTB.private_ip}"
      subnet = "${aws_subnet.priv-db-az-b.cidr_block}"
  }
}

resource "ansible_host" "SQL003" {
  inventory_hostname = "${aws_instance.SQLC.private_dns}"
  groups = ["db"]
  vars = {
      ansible_user = "ubuntu"
       role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTB.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTB.private_ip}"
      subnet = "${aws_subnet.priv-db-az-b.cidr_block}"
  }
}

resource "ansible_host" "REDIS001" {
  inventory_hostname = "${aws_instance.REDISA.private_dns}"
  groups = ["redis"]
  vars = {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTA.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTA.private_ip}"
  }
}

resource "ansible_host" "REDIS002" {
  inventory_hostname = "${aws_instance.REDISB.private_dns}"
  groups = ["redis"]
  vars = {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTB.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTB.private_ip}"
  }
}

resource "ansible_host" "CONSUL001" {
  inventory_hostname = "${aws_instance.CONSULA.private_dns}"
  groups = ["consul"]
  vars ={
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTA.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTA.private_ip}"
  }
}


resource "ansible_host" "CONSUL002" {
  inventory_hostname = "${aws_instance.CONSULB.private_dns}"
  groups = ["consul"]
  vars = {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTA.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTA.private_ip}"
  }
}

resource "ansible_host" "CONSUL003" {
  inventory_hostname = "${aws_instance.CONSULC.private_dns}"
  groups = ["consul"]
  vars = {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTB.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTB.private_ip}"
  }
}

resource "ansible_host" "PGBOUNCER001" {
  inventory_hostname = "${aws_instance.PGBOUNCERA.private_dns}"
  groups = ["pgbouncer"]
  vars = {
      ansible_user = "ubuntu"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTB.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTB.private_ip}"
  }
}

resource "ansible_host" "GITALY001" {
  inventory_hostname = "${aws_instance.GITALYA.private_dns}"
  groups = ["gitaly"]
  vars = {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/privkey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOSTA.public_dns}\""
      ansible_ssh_private_key_file="/tmp/privkey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOSTA.private_ip}"
      subnet = "${aws_subnet.pub-web-az-a.cidr_block}"
  }
}

resource "ansible_host" "LB001" {
  inventory_hostname = "${aws_elb.lb.dns_name}"
  groups = ["lb"]
  vars = {
    lb_external_url = "${aws_elb.lb.dns_name}"
  }
}