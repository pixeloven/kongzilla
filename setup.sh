#!/bin/bash
set -e

# Constants
MAX_ATTEPTS=10
RETRY_WAIT=2 

NAME="admin-api"
ROUTE="/admin"
HOST="localhost"
PORT="8001"
USERNAME="konga"

# Health check on kong before going further
attempts=0
until curl --location --request GET 'http://localhost:8001/'; do
    if [ $attempts -gt $MAX_ATTEPTS ]
    then
        echo "Kong is unavailable - max retry attempts reached"
        exit 1;
    fi
    echo "Kong is unavailable - sleeping"
    sleep $RETRY_WAIT
    ((++attempts))
done
echo "Kong is up - executing setup sequence beep boop beep"

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
    "paths": ["/admin"]
}' | jq '.'

# Enable Key Auth Plugin
curl -X POST 'http://localhost:8001/services/admin-api/plugins' \
    --data "name=key-auth" | jq '.'

# Add Konga as Consumer
curl --location --request POST 'http://localhost:8001/consumers/' \
    --form 'username=konga' | jq '.'

# Create API Key for Konga
curl --location --request POST 'http://localhost:8001/consumers/konga/key-auth' | jq '.'

echo "======================================"
echo "Name: $NAME"
echo "Loopback API: http://$HOST:$PORT$ROUTE"
echo "Key: "
echo "======================================"

# @todo automate admin setup for konga? and if possible automate the setup above...
    # once we get this script
    # do this and then regen all of the config - rename it admin.yml -- we can use this to automate the setup I thinks?
    # Since this is for local dev the key will be stale but that is ok... we may want to re generate the key though?
