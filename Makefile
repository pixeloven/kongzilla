setup:
	COMPOSE_PROFILES=setup,migrations docker-compose build kong-setup
	COMPOSE_PROFILES=setup,migrations KONG_DATABASE=postgres docker-compose up -d
# COMPOSE_PROFILES=setup docker-compose run --rm kong-deck dump -o /opt/kong/backup.yaml

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