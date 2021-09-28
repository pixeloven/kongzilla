# Add Kong Admin API as services
curl --location --request POST 'http://localhost:8001/services/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "admin-api",
    "host": "localhost",
    "port": 8001
}'

# Add Admin API route
curl --location --request POST 'http://localhost:8001/services/admin-api/routes' \
--header 'Content-Type: application/json' \
--data-raw '{
    "paths": ["/admin-api"]
}'

# Enable Key Auth Plugin
curl -X POST http://localhost:8001/services/admin-api/plugins \
    --data "name=key-auth" 

# Add Konga as Consumer
curl --location --request POST 'http://localhost:8001/consumers/' \
--form 'username=konga'

# Create API Key for Konga
curl --location --request POST 'http://localhost:8001/consumers/konga/key-auth'

# @todo use jq to parse output here and return readable output to be entered in
# @todo automate admin setup for konga? and if possible automate the setup above...
    # simplest approach might be to seperate konga DB from konga... then we can dump and reload?