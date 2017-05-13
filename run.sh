#!/bin/bash

# https://docs.docker.com/compose/extends/#example-use-case

docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
