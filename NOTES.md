# Project goals
- [X] Add konga for development
- [X] Setup admin api setup script for konga
- [X] Setup deck for sync/dump of configuration
- [X] Create short simple make file alias for syncing to and from with deck
- [X] Automate basic kong setup starting by locking down admin api
- [] Automate basic konga setup (admin user setup, connection setup, etc)
- [] Test Konga with swarm kong setup 
- [] Break docker configuration into development and production
- [] Lock down docker image versions and get to the latest of each
- [] some sort of process manager might help to prevent race conditions on startup - especially true for the setup script and migrations
- [] need to find a smart way to hide sensitive values from the configs - https://github.com/Kong/vault-kong-secrets
- [] Docker compose env vs deck.yaml config - good to check presidence deck.yaml for defaults in the image then docker-compose can override?
- [] switch to python vs bash for setup - going to need more powerful tooling for handling migrations for Konga (also propose to that project once POC is ready)

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
