# OwnCloud

Run OwnCloud under the control of supervisor daemon in a docker container.

## Overview

Ubuntu Vivid/Trusty  images with :

+ owncloud
+ supervisord
+ sshd

built on the top of the formal Ubuntu images.

## TAGS

+ latest - vivid
+ vivid
+ trusty

## Pull Image

```
$ sudo docker pull classcat/owncloud
```

## Usage

```
$ sudo docker run -d --name (container name) \  
-p 2022:22 -p 443:443 \
--link (mysql container name):mysql \  
-e ROOT_PASSWORD=(root password) \  
-e SSH_PUBLIC_KEY="ssh-rsa xxx" \  
-e MYSQL_ROOT_PASSWORD=(mysql root password) \  
-e MYSQL_OC_DBNAME=dbname \  
-e MYSQL_OC_USERNAME=username \  
-e MYSQL_OC_PASSWORD=password \  
-e OC_DATA_PATH=(data directory path) \  
classcat/owncloud
```
