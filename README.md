# Docker image for dante proxy server

### Configure

You can change the `username`, `password` and `port` options of this image by
editing the part of this `Dockerfile` where the environment variables are set:

* `ENV DANTE_USERNAME username`

* `ENV DANTE_PASSWORD password`

* `ENV DANTE_PORT 1080`

## Build

```bash

  git@github.com:zinovyev/dante-docker.git
  cd dante-docker
  docker build -t dante:test .

```

## Run

Locally:

```bash

  docker run dante:test

```

On your remote server use your remote IP and the port specified in the `Dockerfile`:

```bash

  docker run -p <your-remote-ip>:<port>:<port> dante:test

```

## Test

Figure out the IP of your running container with help of `inspect` command:

```bash

  docker inspect dante-test | grep IPAddress

```

If the IP is `172.17.0.2` (remembers to replace `username`, `password` and `1080` with your own values):

```bash

  curl -v -x socks5://username:password@172.17.0.2:1080 https://www.zinovyev.net

```
