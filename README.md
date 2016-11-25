# Container Guestbook based on Redis and Python containers

This is a sample on how to use Python with Redis container together for a simple guestbook. We use the following two container images from Docker Hub:

  * [Redis database container](https://github.com/sclorg/redis-container)
  * [Python 3.5 builder container](https://github.com/sclorg/s2i-python-container)


## Building
To build the container with guestbook app on top of Python 3.5 builder container, you may either use the Dockerfile or s2i binary available in source-to-image package (recommended way). The following steps show the later variant:

First, install and start the docker daemon and pull container images for Redis and Python. We also install `s2i` binary:

```
[root]# dnf install docker source-to-image
[root]# systemctl start docker
[root]# docker pull centos/redis-32-centos7
[root]# docker pull centos/python-35-centos7
```

Now we can get the application source and build a new container using `s2i` tool:

```
[root]# git clone https://github.com/hhorak/guestbook-redis-python.git
[root]# cd guestbook-redis-python/
[root]# s2i build app centos/python-35-centos7 guestbookapp
```

Now we have new image available locally, called `guestbookapp`.


## Launching
To launch the guestbook container, we need to run the redis container first:

```
[root]# docker run -d -p 6379:6379 --name redis centos/redis-32-centos7
```

Now run the application itself:

```
[root]# docker run --name testapp -d --link redis:redis guestbookapp
```

Finally we can use the app via HTTP, once we get the IP of the guestbook container:

```
[root]# docker inspect testapp |grep IP
[root]# wget 172.17.0.3:8080
```

