#!/bin/bash
set -e

# Constants
MAX_ATTEPTS=10
RETRY_WAIT=2 

NAME="admin-api"
ROUTE="/admin"
LOCAL_HOST_ADDRESS="127.0.0.1"
LOCAL_PORT="8001"
LOCAL_HOST="kong"
PROXY_PORT="8000"
USERNAME="konga"

# Health check on kong before going further
attempts=0
until curl --location --request GET 'http://kong:8001/'; do
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
curl --location --request POST 'http://kong:8001/services/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "admin-api",
    "host": "127.0.0.1",
    "port": 8001
}' | jq '.'

# Add Admin API route
curl --location --request POST 'http://kong:8001/services/admin-api/routes' \
--header 'Content-Type: application/json' \
--data-raw '{
    "paths": ["/admin"]
}' | jq '.'

# Enable Key Auth Plugin
curl -X POST 'http://kong:8001/services/admin-api/plugins' \
    --data "name=key-auth" | jq '.'

# Add Konga as Consumer
curl --location --request POST 'http://kong:8001/consumers/' \
    --form 'username=konga' | jq '.'

# Create API Key for Konga
API_KEY=$(curl --location --request POST 'http://kong:8001/consumers/konga/key-auth' | jq --raw-output '.key')

# @todo Add test to verify key works
# @todo health check on konga would make it so it doesn't just immediate exit
    # ideally it waits
# @todo we should output this to a file?

echo -e "Kong configured - succesfully secured admin api\n"
echo "Run: make kong-db"
echo "Konga dashboard available: http://$LOCAL_HOST_ADDRESS:1337/"
echo -e "Register a new Konga admin account and proceed to connect Konga to Kong with the credentials below\n\n"

echo "Key Auth:"
echo "============================================================"
echo "Name: $NAME"
echo "Loopback API: http://$LOCAL_HOST:$PROXY_PORT$ROUTE"
echo "Key: $API_KEY"
echo "============================================================"
