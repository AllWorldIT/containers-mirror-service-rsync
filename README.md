[![pipeline status](https://gitlab.conarx.tech/containers/mirror-service-rsyncd/badges/main/pipeline.svg)](https://gitlab.conarx.tech/containers/mirror-service-rsyncd/-/commits/main)

# Container Information

[Container Source](https://gitlab.conarx.tech/containers/mirror-service-rsyncd) - [GitHub Mirror](https://github.com/AllWorldIT/containers-mirror-service-rsyncd)

This is the Conarx Containers Mirror Rsyncd Service image, it provides the rsync service for mirrors.



# Mirrors

|  Provider  |  Repository                                           |
|------------|-------------------------------------------------------|
| DockerHub  | allworldit/mirror-service-rsyncd                      |
| Conarx     | registry.conarx.tech/containers/mirror-service-rsyncd |



# Conarx Containers

All our Docker images are part of our Conarx Containers product line. Images are generally based on Alpine Linux and track the
Alpine Linux major and minor version in the format of `vXX.YY`.

Images built from source track both the Alpine Linux major and minor versions in addition to the main software component being
built in the format of `vXX.YY-AA.BB`, where `AA.BB` is the main software component version.

Our images are built using our Flexible Docker Containers framework which includes the below features...

- Flexible container initialization and startup
- Integrated unit testing
- Advanced multi-service health checks
- Native IPv6 support for all containers
- Debugging options



# Community Support

Please use the project [Issue Tracker](https://gitlab.conarx.tech/containers/mirror-service-rsyncd/-/issues).



# Commercial Support

Commercial support for all our Docker images is available from [Conarx](https://conarx.tech).

We also provide consulting services to create and maintain Docker images to meet your exact needs.



# Environment Variables

Environment variables are available from...
* [Conarx Containers Alpine image](https://gitlab.conarx.tech/containers/alpine)



# Volumes


## /data

Mirror data directory.

Files and directories should be owned by 1001:1001.


## /etc/rsyncd.conf.d

Rsyncd configuration.



# Exposed Ports

SSH port 873 is exposed.



# Configuration

Configuration of the mirror is done by mounting a rsyncd configuration file into `/etc/rsyncd.conf.d`.

An example of a configuration file can be found below...
```
[test]
        path = /data
        comment = Test
```
