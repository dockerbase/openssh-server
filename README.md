## Docker Base: Openssh-server


This repository contains **Dockerbase** of [Openssh-sever](http://www.openssh.com/) for [Docker](https://www.docker.com/)'s [Dockerbase build](https://registry.hub.docker.com/u/dockerbase/openssh-server/) published on the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Depends on:

* [dockerbase/ubuntu](https://registry.hub.docker.com/u/dockerbase/ubuntu/)


### Installation

1. Install [Docker](https://docs.docker.com/installation/).

2. Download [Dockerbase build](https://registry.hub.docker.com/u/dockerbase/openssh-server/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull dockerbase/openssh-server`


### Usage

    $ docker run -it --rm dockerbase/openssh-sever
    # service ssh start
    # enable_insecure_key

### Client to connect

    $ sudo make ssh

