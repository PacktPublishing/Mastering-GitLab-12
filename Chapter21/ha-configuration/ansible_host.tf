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

resource "ansible_host" "FRONTEND003" {
  inventory_hostname = "${aws_instance.FRONTEND_C.private_dns}"
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

resource "ansible_host" "SIDEKIQ001" {
  inventory_hostname = "${aws_instance.SIDEKIQ_A.private_dns}"
  groups = ["middleware"]
  vars
  {
      ansible_user = "ubuntu"
      role = "all"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-a.cidr_block}"
  }
}

resource "ansible_host" "SIDEKIQ002" {
  inventory_hostname = "${aws_instance.SIDEKIQ_B.private_dns}"
  groups = ["middleware_asap"]
  vars
  {
      ansible_user = "ubuntu"
      role = "asap"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-b.cidr_block}"
  }
}

resource "ansible_host" "SIDEKIQ003" {
  inventory_hostname = "${aws_instance.SIDEKIQ_C.private_dns}"
  groups = ["middleware_pipeline"]
  vars
  {
      ansible_user = "ubuntu"
      role = "ci_pipeline"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-b.cidr_block}"
  }
}

resource "ansible_host" "SIDEKIQ004" {
  inventory_hostname = "${aws_instance.SIDEKIQ_D.private_dns}"
  groups = ["middleware_realtime"]
  vars
  {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-b.cidr_block}"
  }
}


resource "ansible_host" "GRAFANA001" {
  inventory_hostname = "${aws_instance.GRAFANA_A.private_dns}"
  groups = ["monitoring-dashboard"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-a.cidr_block}"
  }
}

resource "ansible_host" "PROMETHEUS001" {
  inventory_hostname = "${aws_instance.PROMETHEUS_A.private_dns}"
  groups = ["monitoring-server"]
  vars
  {
      ansible_user = "ubuntu"
      role = "slave"
      ansible_ssh_private_key_file="/tmp/mykey.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.public-frontend_az-a.cidr_block}"
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

resource "ansible_host" "REDIS003" {
  inventory_hostname = "${aws_instance.REDIS_C.private_dns}"
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

resource "ansible_host" "GITALY001" {
  inventory_hostname = "${aws_instance.GITALY_A.private_dns}"
  groups = ["gitaly"]
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
