# Files in this directory:
Readme.md - this file 

# Commands used in Chapter 4

## Initiate a CVS repo
``` 
cvs -d ~/cvsroot init
```

## Run Rake import task for GitLab Omnibus installations
``` 
sudo gitlab-rake "import:github[<personal_access_token>,<gitlab user>,<namespace/project>,<source_github_namepsace>/<github_repo>]"
``` 

## Run Rake import task for GitLab installations from source
``` 
bundle exec rake "import:github[<personal_access_token>,<gitlab user>,<namespace/project>,<source_namespace/github_repo>]" RAILS_ENV=production
``` 

## Run Rake import task for GitLab Omnibus installations
``` 
sudo gitlab-rake "import:github[<personal_access_token>,<gitlab user>,<namespace/project>]""
``` 

## Run Rake import task for GitLab installations from source
``` 
bundle exec rake "import:github[<personal_access_token>,<gitlab user>,<namespace/project>]" RAILS_ENV=production
``` 
