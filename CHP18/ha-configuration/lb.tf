resource "aws_elb" "lb" {
    name_prefix = "${var.environment}-"
    subnets = ["${aws_subnet.public-frontend_az-a.id}", "${aws_subnet.public-frontend_az-b.id}"]
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "TCP:80"
        interval = 30
    }
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
    cross_zone_load_balancing = true
    instances = ["${aws_instance.FRONTEND_A.id}", "${aws_instance.FRONTEND_B.id}"]
    security_groups = ["${aws_security_group.SG-loadbalancer.id}"]
}
 
 resource "aws_lb_cookie_stickiness_policy" "gitlab" {
  name                     = "gitlab-policy"
  load_balancer            = "${aws_elb.lb.id}"
  lb_port                  = 80
  cookie_expiration_period = 600
}
