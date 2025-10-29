.PHONY: help install dev start build up down logs clean restart

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install project dependencies
	npm install

dev: ## Run project in development mode (without Docker)
	npm run dev

start: ## Run project in production mode (without Docker)
	npm start

build: ## Build Docker images
	docker-compose build

up: ## Start containers
	docker-compose up -d

down: ## Stop containers
	docker-compose down

logs: ## Show application logs
	docker-compose logs -f app

logs-all: ## Show logs from all containers
	docker-compose logs -f

restart: down up ## Restart containers

clean: ## Remove containers, volumes and images
	docker-compose down -v --rmi local

mongo-express: ## Start Mongo Express for debugging
	docker-compose --profile debug up -d

shell: ## Access application container shell
	docker exec -it authflow-app sh

mongo-shell: ## Access MongoDB shell
	docker exec -it authflow-mongo mongosh authflow

status: ## Show containers status
	docker-compose ps

rebuild: ## Rebuild images without cache
	docker-compose build --no-cache
	docker-compose up -d

