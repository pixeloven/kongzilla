# Project goals
- [X] Add konga for development
- [X] Setup admin api setup script for konga
- [X] Setup deck for sync/dump of configuration
- [] Create short simple make file alias for syncing to and from with deck
- [] Automate kong/konga setup (decK maybe the secret for most of this) multiple configurations?
- [] Break docker configuration into development and production
- [] Lock down docker image versions and get to the latest of each
- [] some sort of process manager might help to prevent race conditions on startup - especially true for the setup script and migrations

# Setup
make kong-db-migrations
make kong-db
./setup.sh

- Manual setup setup connection with key provided by script
- JQ might make output cleaner for setup script until we can automate with deck

# Other notes
## Check if any changes are present
```
docker-compose run kong-deck diff --state=/opt/kong/kong.yaml

```

## Backup from DB
```
docker-compose run kong-deck dump  -o /opt/kong/kong-prod-test.yaml
```
https://github.com/Kong/deck/issues/371

# References
- https://www.cloudbees.com/blog/ensuring-containers-are-always-running-with-dockers-restart-policy
- https://blog.toast38coza.me/kong-up-and-running-part-2-defining-our-api-gateway-with-ansible/
- https://dev.to/vousmeevoyez/setup-kong-konga-part-2-dan
