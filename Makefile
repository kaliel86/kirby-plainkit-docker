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
dev: vendor/autoload.php node_modules/.yarn-integrity ## Run dev server
	$(dc) up -d
	@echo 'Docker up'
	@echo 'PHP server is on : http://localhost:8096'
	@echo 'Hot Reload server is on : http://localhost:3000'

.PHONY: start
start: ## Run docker container
	$(dc) up -d
	@echo 'Docker up. Server listening on : http://localhost:8096'

.PHONY: stop
stop: ## Stop docker container
	$(dc) down
	@echo 'Docker containers stopped'

.PHONY: bash
bash: ## bash into php container
	$(de) php bash


.PHONY: ci
ci: ## Install dependencies in production environment
	composer install --no-dev --ignore-platform-reqs

## dependencies

composer.lock: composer.json
	$(php) composer update

vendor/autoload.php: composer.lock
	$(php) composer install
	touch vendor/autoload.php

yarn.lock: package.json
	$(node) yarn

node_modules/.yarn-integrity: yarn.lock
	$(node) yarn
