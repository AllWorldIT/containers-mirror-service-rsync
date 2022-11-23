# Introduction

This is the AllWorldIT Mirror Rsync service image, used for building mirrors and adding Rsync support.

Check the [Alpine Base Image](https://gitlab.iitsp.com/allworldit/docker/alpine/README.md) for more settings.

This image has a health check which checks `localhost` for a response.



# Environment

No options available.



# Exposed ports

## Port 873

Rsync daemon port 873 is exposed.



# Volumes

## Volume: /data

The /data volume is used for storing of mirror data.



# Configuration

Configuration of the mirror is done by mounting a rsyncd configuration file into `/etc/rsyncd.conf.d`.

An example of a configuration file can be found below...
```
[test]
        path = /data
        comment = Test
```


