# Commands used in Chapter 1

Files in this directory:
Readme.md - this file
nginx.config - a sample configuration file for NGINX


# Installing NGINX on apt-based distros like Debian and Ubuntu
sudo apt-get update
sudo apt-get install nginx

# Using Homebrew on macOS
brew install nginx

# Run nginx config
nginx -c /path/to/nginx.config

# Installing Unicorn

gem install rails

gem install unicorn

# Install new rails app
mkdir /usr/local/www
chmod 755 /usr/local/www
cd /usr/local/www
rails new gitlab-app

# Download a unicorn default config
cd gitlab-app/config
wget https://raw.github.com/defunkt/unicorn/master/examples/unicorn.conf.rb

# Change the path to the socket in the config file
listen app_path + '/tmp/sockets/unicorn.sock', backlog: 64

# Start Unicorn
unicorn -c config/unicorn.rb

# Debug the Unicorn socket
ruby unicorn_status.rb /var/opt/gitlab/gitlab-rails/sockets/gitlab.socket 10

# Redis

# Install Redis on macOS
brew install redis

# Install on Linux 
apt-get install redis
or
yum install redis

# Start Redis
brew services start redis
or 
redis-server

# Test a Redis instance
redis-cli ping








