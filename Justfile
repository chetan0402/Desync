default:
    just --list

lint:
    buf lint
    golangci-lint run ./internal/... ./cmd/...
    pnpm -r lint

fmt:
    golangci-lint fmt ./internal/... ./cmd/...
    pnpm -r format

gen:
    buf generate
    just gen-ent
    go mod tidy
    just fmt

gen-ent:
    go run -mod=mod entgo.io/ent/cmd/ent generate ./internal/ent/schema

test-backend:
    docker run --rm -d --name desync-test-db -e POSTGRES_USER=desync -e POSTGRES_PASSWORD=desync -e POSTGRES_DB=desync -p 5432:5432 postgres:latest -c logging_collector=on -c log_statement=all -c log_filename=postgresql.log
    until docker exec desync-test-db pg_isready -U desync; do sleep 1; done
    go test -v ./internal/...
    docker stop desync-test-db

test-backend-cleanup:
    docker stop desync-test-db || true