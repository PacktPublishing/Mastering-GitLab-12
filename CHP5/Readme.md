# Commands used in Chapter 5

Initiate a CVS repo
``` 
cvs -d ~/cvsroot init
```

Add it to your shell environment
``` 
echo "export CVSROOT=~/cvsroot; export CVSEDITOR=vim" >> ~/.bash_profile
``` 

Import an example roject
``` 
cvs import -m "Example project" cvsproject  test initial
``` 

Checkout again in a working directory(not the same as directory that was imported)
``` 
cvs checkout cvsproject
``` 

Add a file to the repo (has to exist)
``` 
cvs  add secondfile.txt
``` 

Commit a file using a commit message
``` 
cvs commit -m "Added secondfile"
``` 

View cvs log
``` 
cvs log
```

Get cvs-fast-export software
``` 
wget http://www.catb.org/~esr/cvs-fast-export/cvs-fast-export-{$version}.tar.gz
``` 

Copy and move to usable location
```
make cvs-fast-export
p cvs-fast-export /usr/local/bin; chmod +x /usr/local/bin/cvs-fast-export
``` 

Import data into a empty git repository
```
cat {$exportfile} |git fast-import
``` 

Converting data using cvs2git
``` ./cvs2git --blobfile=/tmp/git-blob.dat --dumpfile=/tmp/git-dump.dat "--username=Firstname Lastname" ~/cvsroot
 ``` 

Import the blob file
``` 
git fast-import --export-marks=/tmp/git-marks.dat < /tmp/git-blob.dat
``` 

Import the git metadata
``` 
git fast-import --import-marks=/tmp/git-marks.dat < /tmp/git-dump.dat
``` 
