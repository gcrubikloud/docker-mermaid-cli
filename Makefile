# Ensure the targets are always run. Needed to prevent side effects when running with "-q"
.PHONY: build debug
default: build;

APP_NAME := "mermaid-cli"
REPO_NAME := "sc250024"
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
VERSION := $(shell git rev-parse --abbrev-ref HEAD)

# Bring up
build:
	${INFO} "Building version ${VERSION} of ${APP_NAME}..."
	@docker build -t ${REPO_NAME}/${APP_NAME}:latest -t ${REPO_NAME}/${APP_NAME}:${VERSION} ${ROOT_DIR}

debug:
	@echo ${ROOT_DIR}
	@echo ${VERSION}

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
