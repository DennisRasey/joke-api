FROM alpine:3.19.1
MAINTAINER drasey@babbee.org

# add base and community repositories

ADD repositories /etc/apk/repositories
RUN apk add -X https://nl.alpinelinux.org/alpine/edge/main -u alpine-keys --allow-untrusted --no-cache
RUN apk add --update python3 py3-pip@community --no-cache

# install dependencies
RUN pip3 install flask
RUN pip3 cache purge


# create application directory
RUN mkdir -p /opt/joke_api/joke_api
ADD joke_api /opt/joke_api/joke_api
ADD entrypoint.sh /opt/joke_api/entrypoint.sh

# volume configuration
VOLUME ["/opt/joke_api/instance"]

# start application
CMD "/opt/joke_api/entrypoint.sh"

# listen on port 5000
EXPOSE 5000
