# Files in this directory:
Readme.md - this file 

# HA-configuration

In the directory ha-configuration you fill find example project which show jow to create a HA GitLab configuration. More info in the README.md there.

``` 
.
├── README.md
├── ansible.cfg
├── ansible_host.tf
├── deploy
│   ├── files
│   ├── install-bastions-hosts.yml
│   ├── install-consul.yml
│   ├── install-gitlab.yml
│   ├── install-nfs.yml
│   ├── install-pgbouncer.yml
│   ├── install-postgres-core.yml
│   ├── install-postgres-slaves.yml
│   ├── install-redis.yml
│   └── templates
│       ├── databases.ini.j2
│       ├── gitlab.rb.consul.j2
│       ├── gitlab.rb.j2
│       ├── gitlab.rb.pgbouncer.j2
│       ├── gitlab.rb.postgres.j2
│       ├── gitlab.rb.redis.j2
│       ├── nfs_exports.j2
│       └── pgpass.j2
├── images
│   └── terraform-ha1.xml
├── instance.tf
├── internet_gateway.tf
├── keypair.tf
├── lb.tf
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