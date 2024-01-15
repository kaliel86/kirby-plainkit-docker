user := $(shell id -u)
group := $(shell id -g)
dc := USER_ID=$(user) GROUP_ID=$(group) docker compose
de := $(dc) exec
dr := $(dc) run --rm
node := $(dr) node
php := $(dr) --no-deps php

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: dev
dev: vendor/autoload.php node_modules ## Run dev server
	$(dc) up
	@echo 'Docker up'
	@echo 'PHP server is on : http://localhost:8000'

.PHONY: bash
bash: ## bash into php container
	$(de) php bash

.PHONY: build
build: node_modules ## Compile frontend assets
	$(node) pnpm build

.PHONY: ci
ci: ## Install dependencies in production environment
	composer install --no-dev --ignore-platform-reqs


## dependencies

composer.lock: composer.json
	$(php) composer update

vendor/autoload.php: composer.lock
	$(php) composer install

pnpm-lock.yaml: package.json
	$(node) pnpm install

node_modules: pnpm-lock.yaml
	$(node) pnpm install
