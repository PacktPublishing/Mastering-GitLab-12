output "lb_address"{
    value ="${aws_elb.lb.dns_name}"
}
output "bastionhost_fqdn" {
    value= "${aws_instance.bastion_host.public_dns}"
}
output "bastionhost_private_ip" {
    value= "${aws_instance.bastion_host.private_ip}"
}
output "gitlab" {
    value= "${aws_instance.bastion_host.private_ip}"
}

output "gitlabhost_fqdn" {
    value = "${aws_instance.gitlab_host.public_dns}"
}