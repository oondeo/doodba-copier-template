#!/bin/bash

NAME=$(docker compose ps odoo --format '{{.Name}}')
docker exec -ti $NAME export bash -c export > /tmp/Envfile

docker export $NAME -o /tmp/$NAME.tar
cd /tmp
sed -i 's/declare \-x PGHOST.*/declare -x PGHOST="localhost"/g' Envfile
tar -rvf $NAME.tar Envfile
