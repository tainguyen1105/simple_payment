postgres:
	docker run --name postgres_payment -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=281204 -d postgres:16-alpine

createdb:
	docker exec -it postgres_payment createdb --username=root --owner=root simple_payment

dropdb:
	docker exec -it postgres_payment dropdb simple_payment

migrateup:
	migrate -path db/migration -database "postgresql://root:281204@localhost:5433/simple_payment?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:281204@localhost:5433/simple_payment?sslmode=disable" -verbose down

.PHONY:	postgres	createdb	dropdb	migrateup	migratedown