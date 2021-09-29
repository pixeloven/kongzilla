#!/bin/sh

# Add Kong Admin API as services
curl --location --request POST 'http://localhost:8001/services/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "admin-api",
    "host": "localhost",
    "port": 8001
}' | jq '.'

# Add Admin API route
curl --location --request POST 'http://localhost:8001/services/admin-api/routes' \
--header 'Content-Type: application/json' \
--data-raw '{
    "paths": ["/admin-api"]
}' | jq '.'

# Enable Key Auth Plugin
curl -X POST http://localhost:8001/services/admin-api/plugins \
    --data "name=key-auth" | jq '.'

# Add Konga as Consumer
curl --location --request POST 'http://localhost:8001/consumers/' \
--form 'username=konga' | jq '.'

# Create API Key for Konga
curl --location --request POST 'http://localhost:8001/consumers/konga/key-auth' | jq '.'

# @todo use jq to parse output here and return readable output to be entered in
    # https://stedolan.github.io/jq/download/
    # might be workth creating a setup container... to do this as well as run the setup scripts
# @todo automate admin setup for konga? and if possible automate the setup above...
    # once we get this script
    # do this and then regen all of the config - rename it admin.yml -- we can use this to automate the setup I thinks?
    # Since this is for local dev the key will be stale but that is ok... we may want to re generate the key though?
# @todo would be nice to do a quick health check and exit gracefully alerting to being unable to connect