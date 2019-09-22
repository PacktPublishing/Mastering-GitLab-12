# Files in this directory:
Files in this directory:
Readme.md - this file

# Commands used in Chapter 2

## Reconfigure GitLab
``` 
gitlab-ctl reconfigure
``` 

## Install prerequisites
``` 
sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld
``` 

## Enable mail
``` 
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix
``` 

## Run Omnibus install
``` 
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
``` 

## Prerequisites when  installing from source
``` 
sudo apt-get install -y vim
sudo update-alternatives --set editor /usr/bin/vim.basic
``` 

## Install required packages on Debian
``` 
sudo apt-get install -y build-essentials \
zlib1g-dev\
libyaml-dev\
libssl-dev \
libgdbm-dev \
libre2-dev \
libreadline-dev \
libncurses5-dev \
libffi-dev \
curl \
openssh-server \
libxml2-dev \
libxslt-dev \
libcurl4-openssl-dev \
libicu-dev logrotate \
rsync \
python-docutils \
pkg-config \
cmake \
wget
``` 

## Change locale
``` 
sudo apt-get update 
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8
sudo apt-get install -y curl openssh-server ca-certificates 
``` 

## Install Git
``` 
sudo apt-get install -y libcurl4-openssl-dev libexpat1-dev gettext libz-dev libssl-dev build-essential
cd /tmp
curl --silent --show-error --location https://ftp.pcre.org/pub/pcre/pcre2-10.33.tar.gz --output pcre2.tar.gz
tar -xzf pcre2.tar.gz
cd pcre2-10.33
chmod +x configure
./configure --prefix=/usr --enable-jit
make
sudo make install
cd /tmp
curl --remote-name --location --progress https://www.kernel.org/pub/software/scm/git/git-2.22.0.tar.gz
echo 'a4b7e4365bee43caa12a38d646d2c93743d755d1cea5eab448ffb40906c9da0b  git-2.22.0.tar.gz' | shasum -a256 -c - && tar -xzf git-2.22.0.tar.gz
cd git-2.22.0/
./configure --with-libpcre
make prefix=/usr/local all
sudo make prefix=/usr/local install

``` 

## Install graphicsmagick:
```  
sudo apt-get install -y graphicsmagick
```  

## Install Postfix
``` 
sudo apt-get install -y postfix
``` 

## Remove the old Ruby
``` 
sudo apt-get remove ruby1.8
``` 

## Get the newest Ruby
``` 
wget https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.3.tar.gz
shasum ruby-2.6.3.tar.gz 
cd ruby-2.6.3
./configure --disable-install-rdoc
make
sudo make install
``` 

## Install bundler
``` 
sudo gem install bundler --no-document --version '< 2'
``` 

## Get Golang
``` 
wget https://dl.google.com/go/go1.11.10.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.11.10.linux-amd64.tar.gz
sudo ln -sf /usr/local/go/bin/{go,godoc,gofmt} /usr/local/bin/
rm go1.11.10.linux-amd64.tar.gz
``` 

## Get Nodejs and Yarn
``` 
curl --location https://deb.nodesource.com/setup_12.x | sudo bash -
 sudo apt-get install -y nodejs
curl --silent --show-error https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
xecho "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn
``` 

## Create a GitLab application user
``` 
sudo adduser --disabled-login --gecos 'GitLab user' git
``` 

## Get the postgres database
``` 
sudo apt-get install -y postgresql postgresql-client libpq-dev postgresql-contrib
``` 

## Start the PostgreSQL database
``` 
service postgresql start
``` 

## Create the git database user
``` 
sudo -u postgres psql -d template1 -c "CREATE USER git CREATEDB;"
``` 

## Install the pg_trgm extension
``` 
sudo -u postgres psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
``` 

## Create database command
``` 
sudo -u postgres psql -d template1 -c "CREATE DATABASE gitlabhq_production OWNER git;"
``` 

## Check if the pg_tgrm extensions is enabled
``` 
sudo -u git -H psql -d gitlabhq_production
Postgresql (9.6.10) Type “help” for help.
gitlabhq_production=>
 
SELECT true AS enabled 
FROM pg_available_extensions 
WHERE name = ‘pg_trgm’ 
AND installed_version IS NOT NULL;
``` 

## Change the password for the git database user
``` 
gitlabhq_production=> \password git
Enter new password: <type a password>
Enter it again: <type again this password>
gitlabhq_production=> 
``` 

## Install Redis server via the apt package manager
``` 
sudo apt-get install redis-server
``` 

## Make a backup of the inital Redis configuration
``` 
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.orig
``` 

## Disable Redis listening on a TCP port
``` 
sed 's/^port .*/port 0/' /etc/redis/redis.conf.orig | sudo tee /etc/redis/redis.conf
``` 

## Enable a Redis socket
``` 
echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis/redis.conf
``` 

## Set the permissions for the socket
``` 
echo 'unixsocketperm 770' | sudo tee -a /etc/redis/redis.conf
``` 

## Create the directory which contains the socket
``` 
mkdir /var/run/redis
chown redis:redis /var/run/redis 
chmod 755 /var/run/redis
``` 

## Persist this directory
``` 
if [ -d /etc/tmpfiles.d ]; then
   echo 'd  /var/run/redis  0755  redis  redis  10d  -' | sudo tee -a /etc/tmpfiles.d/redis.conf
 fi
``` 

## Activate the changes
``` 
sudo service redis-server restart
``` 

## Make sure git is part of the Redis group
``` 
sudo usermod -aG redis git
``` 

## Clone the GitLab source
``` 
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b 12-2-stable gitlab
``` 

## Copy the example GitLab config
``` 
cd /home/git/gitlab; sudo -u git -H cp config/gitlab.yml.example config/gitlab.yml
```

## Copy the example secrets file
``` 
sudo -u git -H cp config/secrets.yml.example config/secrets.yml
sudo -u git -H chmod 0600 config/secrets.yml
``` 

## Make sure GitLab can accesss tmp directories
``` 
sudo chown -R git log/
sudo chown -R git tmp/
sudo chmod -R u+rwX,go-w log/
sudo chmod -R u+rwX tmp/
``` 

## Also pid and sockets
``` 
sudo chmod -R u+rwX tmp/pids/
sudo chmod -R u+rwX tmp/sockets/
``` 

## Create directory for uploads
``` 
sudo -u git -H mkdir public/uploads/
``` 

## Make sure only the GitLab user has access to the public/uploads/ directory now that files in public/uploads are served by gitlab-workhorse
``` 
sudo chmod 0700 public/uploads
``` 

## Change the permissions of the directory where CI job traces are stored
``` 
sudo chmod -R u+rwX builds/
``` 

## Change the permissions of the directory where CI artifacts are stored
``` 
sudo chmod -R u+rwX shared/artifacts/
``` 

## Change the permissions of the directory where GitLab Pages are stored
``` 
sudo chmod -R ug+rwX shared/pages/
``` 

#Copy the example Unicorn config
``` 
sudo -u git -H cp config/unicorn.rb.example config/unicorn.rb
``` 

## Find the number of cores
``` 
nproc
``` 

## Enable cluster mode if you expect to have a high load instance Set the number of workers to at least the number of cores Ex. change amount of workers to 3 for 2GB RAM server
``` 
sudo -u git vi config/unicorn.rb
``` 

## Copy the example Rack attack config
``` 
sudo -u git -H cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb
``` 

## Configure Git global settings for git user ‘autocrlf’ is needed for the web editor
``` 
sudo -u git -H git config --global core.autocrlf input
``` 

## Disable ‘git gc –auto’ because GitLab already runs ‘git gc’ when needed
``` 
sudo -u git -H git config --global gc.auto 0
``` 

## Enable packfile bitmaps
``` 
sudo -u git -H git config --global repack.writeBitmaps true
```

## Enable push options
``` 
sudo -u git -H git config --global receive.advertisePushOptions true
``` 

## Configure Redis connection settings
``` 
sudo -u git -H cp config/resque.yml.example config/resque.yml
``` 

## Change the Redis socket path if you are not using the default Debian configuration
``` 
sudo -u git vi config/resque.yml
``` 

## Configure GitLab database settings by copying the template for Postgresql to database.yml
``` 
sudo -u git cp config/database.yml.postgresql config/database.yml
``` 

## Now update the config/database.yml
``` 
sudo -u git vi config/database.yml
``` 

## The minimal lines to change are
``` 
password: "<your secure password>"
host: <your postgres host>
Password is the password you created earlier in the 'SQL database' part of this chapter! The host is the hostname or ip-address of your postgresql database server.
``` 

## Make config/database.yml readable to git only
``` 
sudo -u git -H chmod o-rwx config/database.yml
``` 

## Install Gems
``` 
sudo -u git -H bundle install --deployment --without development test mysql aws kerberos
``` 

## Install GitLab shell
``` 
sudo -u git -H bundle exec rake gitlab:shell:install REDIS_URL=unix:/var/run/redis/redis.sock RAILS_ENV=production SKIP_STORAGE_VALIDATION=true
``` 

## Install GitLab workhorse
``` 
sudo -u git -H bundle exec rake "gitlab:workhorse:install[/home/git/gitlab-workhorse]" RAILS_ENV=production
``` 

## Install Gitaly
``` 
sudo -u git -H bundle exec rake "gitlab:gitaly:install[/home/git/gitaly,/home/git/repositories]" RAILS_ENV=production
``` 

## Restrict Gitaly socket access
``` 
sudo chmod 0700 /home/git/gitlab/tmp/sockets/private
sudo chown git /home/git/gitlab/tmp/sockets/private
``` 

## If you are using non-default settings you need to update config.toml
``` 
cd /home/git/gitaly
sudo -u git vi config.toml
``` 

## start Gitaly
``` 
sudo -u git bash -c "/home/git/gitlab/bin/daemon_with_pidfile /home/git/gitlab/tmp/pids//gitaly.pid /home/git/gitaly/gitaly /home/git/gitaly/config.toml >> /home/git/gitlab/log/gitaly.log 2>&1 &"
``` 

## Initialize the database and activate advanced features
``` 
sudo -u git -H bundle exec rake gitlab:setup RAILS_ENV=production force=yes
``` 

## Set the initial gitlab admin passsord
``` 
sudo -u git -H bundle exec rake gitlab:setup RAILS_ENV=production GITLAB_ROOT_PASSWORD=yourpassword GITLAB_ROOT_EMAIL=youremail DISABLE_DATABASE_ENVIRONMENT_CHECK=1
``` 


## Backup your secrets file(where GitLab stores encryption keys)
``` 
cp config/secrets.yml /to/somewhere/safe
``` 

## Install the Sys-V Init Script
``` 
sudo cp lib/support/init.d/gitlab /etc/init.d/gitlab
``` 

## Active GitLab at boot time
``` 
sudo update-rc.d gitlab defaults 21
``` 

## Make sure log files are rotated frequently (to safe disk space)
``` 
sudo cp lib/support/logrotate/gitlab /etc/logrotate.d/gitlab
``` 

## Check if GitLab and its environment are set right
```  
sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production
``` 

## Compile GetText PO files 
``` 
sudo -u git -H bundle exec rake gettext:compile RAILS_ENV=production
``` 

## Compile assets with yarn
``` 
sudo -u git -H yarn install --production --pure-lockfile
``` 

## Compile the rest of the assets
``` 
sudo -u git -H bundle exec rake gitlab:assets:compile RAILS_ENV=production NODE_ENV=production
``` 

## Start GitLab
``` 
sudo service gitlab start
```
or
```
sudo /etc/init.d/gitlab restart
``` 

## Install NGINX
``` 
sudo apt-get install -y nginx
``` 

## Copy the custom GitLab NGINX config file
``` 
sudo cp lib/support/nginx/gitlab /etc/nginx/conf.d/gitlab.conf 
``` 

## Edit the config file
``` 
sudo vi /etc/nginx/sites-available/gitlab
``` 

## Delete the default nginx config file
``` 
sudo rm -f /etc/nginx/conf.d/default* 
sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -f /etc/nginx/sites-available/default 
``` 

# Restart NGINX to activate the configuration:
``` 
sudo service nginx restart
``` 

## Run GitLab from a Docker contaimer
``` 
sudo docker run \
 --hostname gitlab.joustie.nl \
 --publish 443:443 --publish 80:80 --publish 22:22 \
 --name gitlab \
 --volume /srv/gitlab/config:/etc/gitlab \
 --volume /srv/gitlab/logs:/var/log/gitlab \
 --volume /srv/gitlab/data:/var/opt/gitlab \
 gitlab/gitlab-ce:latest
 ``` 

## Start a shell in the GitLab container
``` 
sudo docker exec -it gitlab /bin/bash
``` 


## Edit the gitlab.rb file in a container
``` 
sudo docker exec -it gitlab vi /etc/gitlab/gitlab.rb
``` 

# Restart container
``` 
sudo docker restart gitlab
``` 

## Start GitLab in a container and start it with extra arguments
``` 
sudo docker run --detach \
 --hostname gitlab.joustie.nl \
 --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.joustie.nl'; gitlab_rails['smtp_address'] = "smtp.server" " \
 --publish 443:443 --publish 80:80 --publish 22:22 \
 --name gitlab \
 --restart always \
 --volume /srv/gitlab/config:/etc/gitlab \
 --volume /srv/gitlab/logs:/var/log/gitlab \
 --volume /srv/gitlab/data:/var/opt/gitlab \
 gitlab/gitlab-ce:latest
``` 

## Stop gitlab docker container
``` 
docker stop gitlab (or sha)
``` 

## Remove gitlab container
``` 
sudo docker rm gitlab (or sha)
``` 

## Pull a new image
``` 
sudo docker pull gitlab/gitlab-ce:latest
``` 

## Recreate a container
``` 
sudo docker run --detach \
--hostname gitlab.joustie.nl \
--publish 443:443 --publish 80:80 --publish 22:22 \
--name gitlab \
--restart always \
--volume /srv/gitlab/config:/etc/gitlab \
--volume /srv/gitlab/logs:/var/log/gitlab \
--volume /srv/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest
```

## Start gitlab container with a different port mapping
``` 
sudo docker run --detach \
 --hostname gitlab.joustie.nl \
 --publish 192.168.1.1:443:443 \
 --publish 192.168.1.1:80:80 \
 --publish 192.168.1.1:22:22 \
 --name gitlab \
 --restart always \
 --volume /srv/gitlab/config:/etc/gitlab \
 --volume /srv/gitlab/logs:/var/log/gitlab \
 --volume /srv/gitlab/data:/var/opt/gitlab \
 gitlab/gitlab-ce:latest
 ``` 

## Check the container logs
``` 
sudo docker logs gitlab
``` 
 
## Run Docker-compose configuration
``` 
docker-compose up -d 
``` 

## Add the GitLab Helm repository
``` 
helm repo add gitlab https://charts.gitlab.io helm init
``` 

## Deploy Helm to Kubernetes
``` 
helm install --namespace yournamespace --name gitlab-runner -f values.yml gitlab/gitlab-runner
``` 

## Initialize and configure Helm
``` 
helm repo add gitlab https://charts.gitlab.io/
helm repo update
``` 

## Deploy GitLab to kubernetes
``` 
helm upgrade --install gitlab gitlab/gitlab \
--timeout 600 \
--set global.hosts.domain=home.joustie.nl \
--set global.hosts.externalIP=<your external ip> \
--set certmanager-issuer.email=admin@joustie.nl
``` 

## Deploy GitLab to Kubernetes with SMTP server defined
``` 
helm upgrade --install gitlab gitlab/gitlab \
 --timeout 600 \
 --set global.hosts.domain=home.joustie.nl \
 --set global.hosts.externalIP=<your external ip> \
 --set certmanager-issuer.email=admin@joustie.nl \
 --set global.smtp.enabled=true \
 --set global.smtp.address=smtp.xs4all.nl \
 --set global.smtp.port=25
``` 

## Get initial admn password when deploying GitLab to Kubernetes
``` 
kubectl get secret <name>-gitlab-initial-root-password -ojsonpath={.data.password} | base64 --decode ; echo
``` 

## Prepare GitLab in Kubernetes for update/upgrade
``` 
helm repo add gitlab https://charts.gitlab.io/
helm repo update
#get the current values
helm get values gitlab > gitlab.yaml
```

## Upgrade after editing gitlab.yaml
``` 
helm upgrade gitlab gitlab/gitlab -f gitlab.yaml
``` 

## Delete GitLab on Kubernetes
``` 
helm delete gitlab
``` 

## Watch logfiles on Digital Ocean droplet 
``` 
tail -100 /var/log/gitlab_set_pass.log
``` 

## Prepare admin password for Digital Ocean droplets
``` 
echo "gitlab_rails[‘initial_root_password’] = ‘nonstandardpassword’" >> /etc/gitlab/gitlab.rb
gitlab-rake gitlab:setup
``` 






