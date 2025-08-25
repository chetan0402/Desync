package main

import (
	"os"

	"github.com/chetan0402/desync/internal"
)

func main() {
	dbUrl := os.Getenv("DESYNC_DATABASE_URL")
	desync.Run(dbUrl)
}
