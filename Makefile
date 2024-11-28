postgres:
	docker run --name dimnyan-psql -e POSTGRES_USER=root -e POSTGRES_PASSWORD=12345 -p 5433:5432 -d postgres:alpine

startdb:
	docker container start dimnyan-psql

createdb:
	docker exec -it dimnyan-psql createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it dimnyan-psql dropdb simple_bank

connectdb:
	docker exec -it dimnyan-psql bash
	#psql -U root

migrateup:
	migrate -path db/migration -database "postgresql://root:12345@localhost:5433/simple_bank?sslmode=disable" -verbose up
	
migratedown:
	migrate -path db/migration -database "postgresql://root:12345@localhost:5433/simple_bank?sslmode=disable" -verbose down
	
sqlc: 
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY:
	postgres startdb createdb dropdb migrateup migratedown sqlc test server