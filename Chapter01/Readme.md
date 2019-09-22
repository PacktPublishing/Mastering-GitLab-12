# Files in this directory:
Readme.md - this file
InstallingRedis.md - instructions how to install Redis
nginx.config - a sample configuration file for NGINX

# Chapter 1, Introducing the GitLab Architecture
This chapter  provides a short introduction to the company and the people that created the product, along with a high-level overview of GitLab and its components.

# Commands used in Chapter 1

## Installing NGINX on apt-based distros like Debian and Ubuntu
``` 
sudo apt-get update
sudo apt-get install nginx
``` 

# Using Homebrew on macOS to install NGINX
``` 
brew install nginx
``` 

# Run a specific NGINX configuration
``` 
nginx -c /path/to/nginx.config
``` 

# Installing Unicorn
``` 
gem install rails

gem install unicorn
``` 

# Install a new rails app
``` 
mkdir /usr/local/www
chmod 755 /usr/local/www
cd /usr/local/www
rails new gitlab-app
``` 

# Download a unicorn default configuration
``` 
cd gitlab-app/config
wget https://raw.github.com/defunkt/unicorn/master/examples/unicorn.conf.rb
``` 

# Change the path to the socket in the config file
``` 
listen app_path + '/tmp/sockets/unicorn.sock', backlog: 64
``` 

# Start Unicorn
``` 
unicorn -c config/unicorn.rb
``` 

# Debug the Unicorn socket
``` 
ruby unicorn_status.rb /var/opt/gitlab/gitlab-rails/sockets/gitlab.socket 10
``` 

# Install Redis on macOS with homebrew
``` 
brew install redis
``` 

# Install on Linux 
``` 
apt-get install redis
``` 
or
``` 
yum install redis
``` 

## Install Redis from source
``` 
curl http://download.redis.io/redis-stable.tar.gz | tar xvz
cd redis-stable
make
sudo make install
``` 

# Start Redis
``` 
brew services start redis
``` 
or 
``` 
redis-server
``` 

# Test a Redis instance
``` 
redis-cli ping
``` 
