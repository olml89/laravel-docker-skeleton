docker_compose_context = --file docker/docker-compose.yml --env-file ./.env

.PHONY: containers-up
containers-up:
	@sudo docker-compose $(docker_compose_context) up -d

.PHONY: containers-down containers-clean
containers-down:
	@sudo docker-compose $(docker_compose_context) down
containers-clear: containers-down
	@sudo docker system prune -a

.PHONY: containers-list
containers-list:
	@sudo docker ps

.PHONY: composer-install
composer-install:
	@sudo docker-compose $(docker_compose_context) exec php-fpm composer install --ignore-platform-reqs

.PHONY: artisan
artisan:
	@sudo docker-compose $(docker_compose_context) exec php-fpm php artisan $(cmd)

.PHONY: application-install
application-install: containers-up composer-install
	@make artisan cmd=key:generate
