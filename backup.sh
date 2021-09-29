#!/bin/sh

NAME="admin-api"
HOST="localhost"
PORT="8001"
USERNAME="konga"

# Add Kong Admin API as services
curl --location --request POST 'http://$HOST:$PORT/services/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "$NAME",
    "host": "$HOST",
    "port": $POST
}' | jq '.'

# Add Admin API route
curl --location --request POST 'http://$HOST:$PORT/services/$NAME/routes' \
--header 'Content-Type: application/json' \
--data-raw '{
    "paths": ["/$NAME"]
}' | jq '.'

# Enable Key Auth Plugin
curl -X POST 'http://$HOST:$PORT/services/$NAME/plugins' \
    --data "name=key-auth" | jq '.'

# Add Konga as Consumer
curl --location --request POST 'http://$HOST:$PORT/consumers/' \
    --form 'username=$USERNAME' | jq '.'

# Create API Key for Konga
# $authKey=(curl --location --request POST 'http://$HOST:$PORT/consumers/$USERNAME/key-auth' | jq '.')
curl --location --request POST 'http://$HOST:$PORT/consumers/$USERNAME/key-auth' | jq '.'

# @todo use jq to parse output here and return readable output to be entered in
    # https://stedolan.github.io/jq/download/
    # might be workth creating a setup container... to do this as well as run the setup scripts
# @todo automate admin setup for konga? and if possible automate the setup above...
    # once we get this script setup we should regent the admin yaml script based on a fresh install
    # do this and then regen all of the config - rename it admin.yml -- we can use this to automate the setup I thinks?
    # Since this is for local dev the key will be stale but that is ok... we may want to re generate the key though?