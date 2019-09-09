#Requirements for chapter 1 on platform Debian 10

# Prepare a Debian 10 machine or VM or cloud instance
# Don't run the commands below as root but use the sudo mechamism
# Set your locale to get rid of locale errors (if you use US English)

```  
vi /etc/profile.d/setlocale.sh
```  

Add the following:

```
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8
```  

Save and login again.
