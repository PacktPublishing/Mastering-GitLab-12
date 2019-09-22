# Installing Redis

Redis is available through all major package management systems. The following are the commands used to install it on different platforms: 

This is for Mac with Homebrew installed:
``` 
brew install redis
```  

This is for Linux Ubuntu or other APT-based distributions:
```  
apt-get install redis 
``` 

This is for Red Hat or other YUM-based distributions:
```  
yum install redis 
``` 

However, the preferred way of installing Redis is by compiling it from the source. This way, you can easily stay up to date. It has no special dependencies other than the GCC compiler and the standard C library. You can find the latest stable version at http://download.redis.io/redis-stable.tar.gz.

Installing and compiling it is as easy as entering the following command:

```  
curl http://download.redis.io/redis-stable.tar.gz | tar xvz
cd redis-stable
make
```  

After completing this successfully, you can choose to carry out the next logical step, which is to issue make test to execute tests against compiled sources.

To install the binary in a useful place, use the following command:

```  
sudo make install
```  

For a further explanation about the structure that has been compiled, go to the src directory. You will find the following information: 

* redis-server: The Redis server program
* redis-sentinel: This is used to monitor Redis clusters
* redis-cli: The command-line program to control Redis
* redis-benchmark: The program to be used to measure Redis performance
* redis-check-aof and redis-check-dump: Utilities to assist when there is data corruption

Now we have everything in place, let's start the server.

When installed on macOS with brew, use the following command:
```  
brew services start redis
```  

On other platforms, when built from the source, you can directly start the Redis server by running the redis-server command. In a fresh shell window, type the following:
```  
redis-server
```  

After hitting Enter, you will see the server starting:



You can test whether your Redis instance is working by issuing the following command:
```  
$ redis-cli ping
```  

When Redis is operational, there will be a reaction:
```  
PONG
```  

If you receive PONG, then everything is in order.
