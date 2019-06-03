# Commands used in Chapter 2

Files in this directory:
Readme.md - this file


# Open firewall on Linux
ufw allow http
ufw allo https
ufw allow OpenSSH

# Reconfigure GitLab
gitlab-ctl reconfigure

# Install prerequisites
sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld

# Enable mail
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix

# Run Omnibus install
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash


# Prerequisites when  installing from source
sudo apt-get install -y vim
sudo update-alternatives --set editor /usr/bin/vim.basic


# Install required packages on Debian
sudo apt-get install -y build-essentials \
zlib1g-dev\
libyaml-dev\
libssl-dev \
libgdbm-dev \
libre2-dev \
libreadline-dev libncurses5-dev libffi-dev curl openssh-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev logrotate rsync python-docutils pkg-config cmake wget

# Change locale
sudo dpkg-reconfigure locales

# Install Git
sudo apt-get install -y git-core

# Install Postfix
sudo apt-get install -y postfix

# Remove the old Ruby
sudo apt-get remove ruby1.8

# Get the newest Ruby
wget https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.5.tar.gz
cd ruby-2.5.5
./configure --disable-install-rdoc
make
sudo make install

# Install bundler
sudo gem install bundler --no-document --version '< 2'

# Get Golang
$ wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
$ echo 'fa1b0e45d3b647c252f51f5e1204aba049cde4af177ef9f2181f43004f901035  go1.10.3.linux-amd64.tar.gz' | shasum -a256 -c - && \
  sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
$ sudo ln -sf /usr/local/go/bin/{go,godoc,gofmt} /usr/local/bin/
$ rm go1.10.3.linux-amd64.tar.gz

#Get Nodejs and Yarn
curl --location https://deb.nodesource.com/setup_8.x | sudo bash -
 sudo apt-get install -y nodejs
 
curl --silent --show-error https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
xecho "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn
 
# Create a GitLab application user
sudo adduser --disabled-login --gecos 'GitLab user' git

# Get the postgres database
sudo apt-get install -y postgresql postgresql-client libpq-dev postgresql-contrib

service postgresql start

sudo -u postgres psql -d template1 -c "CREATE USER git CREATEDB;"

sudo -u postgres psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"

sudo -u postgres psql -d template1 -c "CREATE DATABASE gitlabhq_production OWNER git;"

sudo -u git -H psql -d gitlabhq_production
Postgresql (9.6.10) Type “help” for help.
gitlabhq_production=>
 
SELECT true AS enabled 
FROM pg_available_extensions 
WHERE name = ‘pg_trgm’ 
AND installed_version IS NOT NULL;

gitlabhq_production=> \password git
Enter new password: <type a password>
Enter it again: <type again this password>
gitlabhq_production=> 

sudo apt-get install redis-server

sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.orig








