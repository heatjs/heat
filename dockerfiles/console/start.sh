#!/bin/bash

yarn install;

if [ $NODE_ENV == 'production' ]; then
  yarn start;
else
  nodemon --inspect=0.0.0.0:9229
fi;
