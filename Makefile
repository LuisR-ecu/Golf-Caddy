up: ; docker compost up --build
down: ; docker-compose down
format: ; black api && ruff api
test: ; pytest -q