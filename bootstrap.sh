#!/bin/bash
if [ $(hostname) = "raspberrypi" ]; then 
  echo 'NODE_ENV=pi'
  export NODE_ENV=pi
else
  export NODE_ENV=development
fi

coffee -c public/javascripts/*.coffee
