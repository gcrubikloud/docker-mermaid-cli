# Ensure the targets are always run. Needed to prevent side effects when running with "-q"
.PHONY: build up down local
default: local ;

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Build the image
build:
	@docker build -t yd/mermaidcli:latest .

# Bring up
up:
	@docker-compose up -d --force-recreate
	@docker-compose logs --follow

down:
	@docker-compose down --volumes --rmi local

local: build up down

# Cosmetics
GREEN := "\033[1;32m"
NULL := "\033[0m"
RED := "\033[1;31m"
YELLOW := "\033[1;33m"

# Shell functions
INFO := @bash -c '\
	printf $(GREEN); \
	echo "=> $$1"; \
	printf $(NULL)' VALUE

WARNING := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NULL)' VALUE

ERROR := @bash -c '\
	printf $(RED); \
	echo "=> $$1"; \
	printf $(NULL)' VALUE
