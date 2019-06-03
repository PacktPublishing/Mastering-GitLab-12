
# Files in this directory:
Readme.md - this file 

# Commands used in Chapter 7

## Example of migrating existing Git repository to GitLab
``` 
cd existing_repo
git remote rename origin old-origin
git remote add origin https://gitlab.example.com/me/newprojectingitlab.git
git push -u origin --all
git push -u origin --tags
``` 

## Find out who changed files
``` 
git blame <file>
``` 

## Install Git using chocolatey
``` 
choco install git
``` 

## Install gittfs using chocolaty
``` 
choco install gittfs
``` 

## Pull tfsvc repository into a Git format
``` 
git-tfs clone https://dev.azure.com/<azure account> $/test
```

## View git logs
``` 
git log
``` 
