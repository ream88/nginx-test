#!/bin/bash

# Remove existing containers
docker rm -f $(docker ps -qaf name=nginx)

# Create network
docker network create nginx-test

# Create two isolated nginx containers
docker run -d --name nginx-1 -v $PWD/site-1:/usr/share/nginx/html:ro --network=nginx-test nginx
docker run -d --name nginx-2 -v $PWD/site-2:/usr/share/nginx/html:ro --network=nginx-test nginx

# Create nginx router
docker run --name nginx-router -v $PWD/router/nginx.conf:/etc/nginx/nginx.conf --network=nginx-test -p 80:80 nginx
