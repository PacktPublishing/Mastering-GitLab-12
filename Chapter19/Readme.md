# Files in this directory:
Readme.md - this file 

# HA-configuration

In the directory ha-configuration you fill find example project which show jow to create an HA GitLab configuration. More info in the README.md there.

``` 
.
├── README.md
├── ansible.cfg
├── ansible.tf
├── connect_ssh.sh
├── create_screenfile.sh
├── deploy
│   ├── files
│   ├── install-backend-services.yml
│   ├── install-consul.yml
│   ├── install-frontend-services.yml
│   ├── install-gitaly.yml
│   ├── install-pgbouncer.yml
│   ├── install-postgres-core.yml
│   ├── install-postgres-slaves.yml
│   ├── install-redis.yml
│   ├── install.yml
│   └── templates
│       ├── databases.ini.j2
│       ├── gitlab.rb.backend.j2
│       ├── gitlab.rb.consul.j2
│       ├── gitlab.rb.frontend.j2
│       ├── gitlab.rb.gitaly.j2
│       ├── gitlab.rb.pgbouncer.j2
│       ├── gitlab.rb.postgres.j2
│       ├── gitlab.rb.redis.j2
│       └── pgpass.j2
├── deploy-with-ansible.sh
├── instances.tf
├── keys.tf
├── lb.tf
├── modules
├── networking.tf
├── new_window.sh
├── providers.tf
├── routes.tf
├── security.tf
├── terraform-ha1.xml
└── variables.tf
``` 