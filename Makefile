kong-db-migrations:
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