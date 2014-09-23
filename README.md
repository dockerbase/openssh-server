## Docker Base: Openssh-server


This repository contains **Dockerbase** of [Openssh-sever](http://www.openssh.com/) for [Docker](https://www.docker.com/)'s [Dockerbase build](https://registry.hub.docker.com/u/dockerbase/openssh-server/) published on the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Depends on:

* [dockerbase/runit](https://registry.hub.docker.com/u/dockerbase/runit/)


### Installation

1. Install [Docker](https://docs.docker.com/installation/).

2. Download [Dockerbase build](https://registry.hub.docker.com/u/dockerbase/openssh-server/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull dockerbase/openssh-server`


### Usage

    $ git clone https://github.com/dockerbase/openssh-server
    $ cd openssh-server
    $ sudo make run         # run a openssh-server container
    $ sudo make enter       # enter the container via nenter
    # enable_insecure_key   # enable the insecure key ( you can replace the key )
    ...
    $ sudo make ssh         # enter the container via ssh
    ...
    $ sudo make stop        # stop the container
    ...
    $ sudo make start       # restart the container
    $ sudo make stop        # stop the container
    $ sudo make rm          # destroy the container

### Components & Versions

    Description:	Ubuntu 14.04.1 LTS
    git version 1.9.1
    OpenSSH_6.6.1p1 Ubuntu-2ubuntu2, OpenSSL 1.0.1f 6 Jan 2014
