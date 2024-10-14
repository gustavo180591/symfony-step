init:
	@sudo apt install mkcert libnss3-tools
	@mkcert -install
	@mkdir -p proxy/certs
	@mkcert -cert-file proxy/certs/local-cert.pem -key-file proxy/certs/local-key.pem "docker.localhost" "*.docker.localhost" "domain.local" "*.domain.local"
	@echo "Generated certificates for "docker.localhost", "domain.local" and their sub-domains"

start:
	docker stop traefik && docker rm traefik
	docker compose -f compose.proxy.yml up -d
	docker compose -f compose.dev.yml up -d

down:
	docker compose -f compose.dev.yml down
	docker compose -f compose.proxy.yml down


build-prod:
	docker-compose -f compose.prod.standalone.yml build
build-front:
	docker-compose -f compose.prod.standalone.yml build benicio-front
build-back:
	docker-compose -f compose.prod.standalone.yml build benicio-back
start-prod:
	docker-compose -f compose.prod.standalone.yml up -d