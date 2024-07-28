isDocker := $(shell docker info > /dev/null 2>&1 && echo 1)
user := $(shell id -u)
group := $(shell id -g)
server := "infomaniak"
domain := "domaine.fr"

kirby := php bin/console
bun :=
php :=

ifeq ($(isDocker), 1)
		dc := USER_ID=$(user) GROUP_ID=$(group) docker compose
		de := docker compose exec
		dr := $(dc) run --rm
		kirby := $(de) php bin/console
		bun := $(dr) bun
		php := $(dr) --no-deps php
endif

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: dev
dev: vendor/autoload.php node_modules/time ## Run dev server
	$(dc) up

.PHONY: bash
bash: ## bash into php container
	$(de) php bash

.PHONY: build
build: node_modules ## Compile frontend assets
	$(node) pnpm build

.PHONY: deploy
deploy: ## Déploie une nouvelle version du site
	ssh -A $(server) 'cd sites/$(domain) && git pull origin/main && make install'

.PHONY: install
install: vendor/autoload.php public/assets/.vite/manifest.json ## Installe les différentes dépendances
	$(php) composer install --no-dev --optimize-autoloader

.PHONY: ci
ci: ## Install dependencies in production environment
	composer install --no-dev --ignore-platform-reqs


## dependencies

composer.lock: composer.json
	$(php) composer update

vendor/autoload.php: composer.lock
	$(php) composer install

node_modules/time: bun.lockb
	$(bun) bun install
	touch node_modules/time


bun.lockb:
	$(bun) bun install

