setup:
	COMPOSE_PROFILES=cli docker-compose build
	COMPOSE_PROFILES=setup,migrations KONG_DATABASE=postgres docker-compose up -d

dump:
	COMPOSE_PROFILES=cli docker-compose run --rm kong-deck dump -o /opt/kong/kong.yaml

sync:
	COMPOSE_PROFILES=cli docker-compose run --rm kong-deck sync

migration:
	COMPOSE_PROFILES=migrations KONG_DATABASE=postgres docker-compose up -d

kong-db:
	COMPOSE_PROFILES=database KONG_DATABASE=postgres docker-compose up -d

kong-dbless:
	docker-compose up -d

clean:
	docker-compose down -v
	docker-compose kill
	docker-compose rm -f

# kong should not attempt to start until after migration is complete?
# setup proper profiles for everything except kong???

# might be good to create a process for a clean setup and dump
# then general user setup would me just to sync yml db with db -- ie there is developer setup vs std setup
# then let'smove on to defining the prod vs local kong setup
# then test against ds

.PHONY: setup
