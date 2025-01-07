SRCS = srcs/

DOCKER_COMPOSE = docker-compose.yml

WORDPRESS_VOL = ${HOME}/data/wordpress

MARIADB_VOL = ${HOME}/data/mariadb
### added --no-cache
all:
	mkdir -p ${WORDPRESS_VOL}
	mkdir -p ${MARIADB_VOL}
	docker compose -f ${SRCS}${DOCKER_COMPOSE} up --no-cache

detach:
	docker compose -f ${SRCS}${DOCKER_COMPOSE} up -d

stop:
	docker compose -f ${SRCS}${DOCKER_COMPOSE} stop

down:
	docker compose -f ${SRCS}${DOCKER_COMPOSE} down -v
	sudo rm -rf ${WORDPRESS_VOL}/*
	sudo rm -rf ${MARIADB_VOL}/*

rebuild: down
	docker compose -f ${SRCS}${DOCKER_COMPOSE} build

clean: down
	docker system prune -a --volumes

fclean: down
	docker system prune -a --volumes -f

re: fclean 
	make all

.PHONY: all detach  stop down rebuild clean fclean re