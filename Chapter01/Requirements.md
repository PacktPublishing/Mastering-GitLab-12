#Debian 9

## Set locale to get rid of locale errors (if you use US English)
vi /etc/profile.d/setlocale.sh
Add 
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8
and login again.

# Update apt-get database
apt-get update

## Install c-compiler and build tools
apt-get install build-essential

## Install ruby and libs
apt-get -y  install ruby
apt-get -y  install ruby-dev
apt-get -y  install zlib1g-dev
apt-get -y  install libsqlite3-dev
apt-get -y  install nodejs

## Install gdb
apt-get -y  install gdb

## Install nginx
apt-get -y install nginx

## Install unicorn
gem install unicorn

## Install rails
gem install rails

## Install sidekiq
gem install sidekiq

## Install gitlab shell


## Install gitaly
