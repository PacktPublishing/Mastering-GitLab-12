# Files in this directory:
Readme.md - this file 

# HA-configuration

In the directory ha-configuration you fill find example project which show jow to create an HA GitLab configuration. More info in the README.md there.

``` 
.
├── README.md
├── ansible.cfg
├── ansible_host.tf
├── deploy
│   ├── files
│   ├── install-bastion-hosts.yml
│   ├── install-consul.yml
│   ├── install-frontend-services-ssl.yml
│   ├── install-frontend-services.yml
│   ├── install-gitaly.yml
│   ├── install-grafana-dashboard.yml
│   ├── install-middleware-services.yml
│   ├── install-pgbouncer.yml
│   ├── install-postgres-core.yml
│   ├── install-postgres-slaves.yml
│   ├── install-prometheus.yml
│   ├── install-redis-cluster-1.yml
│   └── templates
│       ├── databases.ini.j2
│       ├── gitlab.rb.consul.j2
│       ├── gitlab.rb.frontend.j2
│       ├── gitlab.rb.frontend_ssh.j2
│       ├── gitlab.rb.gitaly.j2
│       ├── gitlab.rb.grafana.j2
│       ├── gitlab.rb.middleware.j2
│       ├── gitlab.rb.pgbouncer.j2
│       ├── gitlab.rb.postgres.j2
│       ├── gitlab.rb.prometheus.j2
│       ├── gitlab.rb.redis-cluster.j2
│       ├── gitlab.rb.sidekiq_asap.j2
│       ├── gitlab.rb.sidekiq_pipeline..j2
│       ├── gitlab.rb.sidekiq_realtime.1.j2
│       └── pgpass.j2
├── images
│   ├── terraform-ha1.png
│   └── terraform-ha1.xml
├── instance.tf
├── internet_gateway.tf
├── keypair.tf
├── lb.tf
├── modules
├── provider.tf
├── route_table.tf
├── scripts
│   ├── connect_ssh.sh
│   ├── create_screenfile.sh
│   ├── deploy-with-ansible.sh
│   ├── new_window.sh
│   ├── screen.sh
│   └── superscreen.sh
├── security_group.tf
├── subnet.tf
├── variable.tf
└── vpc.tf
``` 
