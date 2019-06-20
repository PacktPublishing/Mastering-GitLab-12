
module "gitlab_eu" {
  source = "modules/services/gitlab/"
  region = "eu-central-1"
  instance_type = "t2.medium"
  vpc_cidr_block = "10.0.0.0/16"
  subnet_frontend_cidr_block = "10.0.1.0/24"
}
module "gitlab_us" {
  source = "modules/services/gitlab/"
  region = "us-west-2"
  instance_type = "t2.medium"
  vpc_cidr_block = "172.16.0.0/16"
  subnet_frontend_cidr_block = "172.16.1.0/24"
}

resource "ansible_host" "BASTIONHOST001" {
  inventory_hostname = "${module.gitlab_eu.bastionhost_fqdn}"
  groups = ["bastion"]
  vars
  {
      role = "primary"
      ansible_user = "${var.sshuser}"
      ansible_ssh_private_key_file="${var.ssh_private_key_primary}"
      ansible_python_interpreter="${var.python_interpreter}"
  }
}

resource "ansible_host" "BASTIONHOST002" {
  inventory_hostname = "${module.gitlab_us.bastionhost_fqdn}"
  groups = ["bastion"]
  vars
  {
      role = "secondary"
      ansible_user = "${var.sshuser}"
      ansible_ssh_private_key_file="${var.ssh_private_key_secondary}"
      ansible_python_interpreter="${var.python_interpreter}"
  }
}

resource "ansible_host" "GITLABHOST001" {
  inventory_hostname = "${module.gitlab_eu.gitlabhost_fqdn}"
  groups = ["gitlab"]
  vars
  { 
      role = "primary"
      geo_primary_address = "${module.gitlab_eu.lb_address}"
      geo_secondary_address = "${module.gitlab_us.lb_address}"
      ansible_user = "${var.sshuser}"
      ansible_ssh_private_key_file = "${var.ssh_private_key_primary}"
      ansible_python_interpreter = "${var.python_interpreter}"
      ansible_ssh_common_args = " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey1.pem -W %h:%p -q ubuntu@${module.gitlab_eu.bastionhost_fqdn}\""
      proxy = "${module.gitlab_eu.bastionhost_private_ip}"
      subnet = "10.0.1.0/24"
  }
}

resource "ansible_host" "GITLABHOST002" {
  inventory_hostname = "${module.gitlab_us.gitlabhost_fqdn}"
  groups = ["gitlab"]
  vars
  {
      role = "secondary"
      geo_primary_address = "${module.gitlab_eu.lb_address}"
      geo_secondary_address = "${module.gitlab_us.lb_address}"
      ansible_user = "${var.sshuser}"
      ansible_ssh_private_key_file = "${var.ssh_private_key_secondary}"
      ansible_python_interpreter = "${var.python_interpreter}"
      ansible_ssh_common_args = " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/mykey2.pem -W %h:%p -q ubuntu@${module.gitlab_us.bastionhost_fqdn}\""
      proxy = "${module.gitlab_us.bastionhost_private_ip}"
      subnet = "172.16.1.0/24"
  }
}

# resource "ansible_host" "LB001" {
#   inventory_hostname = "${aws_elb.lb.dns_name}"
#   groups = ["lb"]
#   vars
#   {
#     lb_external_url = "${aws_elb.lb.dns_name}"
#   }
# }

# resource "ansible_host" "LB002" {
#   inventory_hostname = "${aws_elb.lb.dns_name}"
#   groups = ["lb"]
#   vars
#   {
#     lb_external_url = "${aws_elb.lb.dns_name}"
#   }
# }


