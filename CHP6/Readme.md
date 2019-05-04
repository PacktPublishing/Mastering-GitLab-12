# Commands used in Chapter 6

Install git-lfs
``` 
brew install git-lfs
```
Enable git-lfs for your repository
``` 
git lfs install
``` 

Tag files as 'large'
``` 
git lfs track "*.dmg"
``` 

Configure subgit to prepare for synchronization
``` 
/opt/subgit/bin/subgit configure --layout auto  $SVN_PROJECT_URL $GIT_REPO_PATH
``` 

Initiate the synchronization between a SVN and Git repository with subgit
``` 
/opt/subgit/bin/subgit install $GIT_REPO_PATH
``` 

Clear the GitLab cache
``` 
gitlab-rake cache:clear
``` 

Perform a one-off conversion between SVN and Git with subgit
``` 
/opt/subgit/bin/subgit import $GIT_REPO_PATH
```

Install svn2git on Mac OSX
``` 
sudo gem install svn2git
``` 

Install svn2git on Debian Linux
```
sudo apt-get install git-core git-svn ruby
``` 

Perform the one-off migratiom from SVN to Git with svn2git
```
svn2git svn://svn.riscos.info/pdf 
``` 
