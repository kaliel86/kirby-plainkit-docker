.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Run docker container
	docker compose up -d
	@echo 'Docker up. Server listening on : http://localhost:8096'
	yarn start

.PHONY: stop
stop: ## Stop docker container
	docker compose down

.PHONY: bash
bash: ## bash into php container
	docker compose exec php bash


.PHONY: ci
ci: ## Install dependencies in production environment
	composer install --no-dev --ignore-platform-reqs
