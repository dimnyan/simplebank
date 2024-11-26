package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
    dbSource = "postgresql://root:12345@localhost:5433/simple_bank?sslmode=disable"
)


var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M){
	var err error
	// Make Connection to DB
	testDB, err = sql.Open(dbDriver, dbSource)
	if err!= nil {
		log.Fatal("Cannot connect to db: ", err)
    }
	testQueries = New(testDB)

	os.Exit(m.Run())
}