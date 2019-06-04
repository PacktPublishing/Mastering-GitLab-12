
# Files in this directory:
Readme.md - this file 

config.tom - a sample configuation file for a GitLab Runner


# Commands used in Chapter 14

## Add yum based installantion repository
``` 
curl -o script.rpm.sh https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh
 less script.rpm.sh #(check the contents, if you are fine with it make it executable and run it)
 chmod +x script.rpm.sh
 ./script.rpm.sh
``` 

## Run a yum based install of the GitLab Runner
``` 
yum install gitlab-runner
``` 

## Pin the GitLab Runner package on Debian

``` 
cat <<EOF >> /etc/apt/preferences.d/pin-gitlab-runner.pref
Explanation: Pin GitLab-runner package
Package: gitlab-runner
Pin: origin packages.gitlab.com
Pin-Priority: 999
EOF
```

# Add the APT repos to the system
``` 
curl -o script.deb.sh https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh
less script.deb.sh #(check the contents, if you are fine with it make it executable and run it)
chmod +x script.deb.sh
./script.deb.sh
``` 

## Install the Runner using APT
``` 
apt-get install gitlab-runner
``` 

## Manually download the x86-64 bit architecture binary
``` 
curl -o /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
``` 


## Manually download the x86-32 bit architecture binary
``` 
curl -o  /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-386
``` 


## Manually download the ARM architecture binary
``` 
curl -o  /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm
``` 

## Add a GitLab Runner use
``` 
useradd --create-home gitlab-runner
``` 

## Install the service and run it
``` 
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
gitlab-runner start
``` 

## Installing on macOS manually
``` 
sudo curl -o  /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-darwin-amd64
```

## Installing on macOS with Homebrew package manager
``` 
brew install gitlab-runner
```

## Start the Runner using the Homebrew package manager
``` 
brew services start gitlab-runner 
``` 

## Register/install/start GitLab Runner on Windows
``` 
c:\gitlab-runner\gitlab-runner.exe register/install/start
``` 

## Registering a GitLab Runner
``` 
sudo gitlab-runner register
``` 

## Get the possible subcommands to the register command
``` 
gitlab-runner register -h
``` 

## One line registration
``` 
sudo gitlab-runner register \
   --description "docker-runner" \
   --url "https://gitlab-ee.joustie.com/" \
   --registration-token "xxxx" \
   --executor "docker" \
   --docker-image alpine:latest \
   --non-interactive \
   --tag-list "docker,aws" \
   --run-untagged="true" \
   --locked="false" \
``` 




