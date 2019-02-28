#!/bin/sh

# Setting 80 as default containet port number if not passed as parameter
PORT=80

if [ "$1" != "" ];
then
  PORT=$1
fi

# Mapping port 8080 from local machine to port $PORT of container and passing $PORT as an environment variable
docker run -e PORT=$PORT --publish 8080:$PORT --name happstack-server happstack-server

