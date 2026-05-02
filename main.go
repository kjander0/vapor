package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	addr := envOrDefault("ADDR", "127.0.0.1:8080")
	wwwDir := envOrDefault("WWW_DIR", "www")

	fileServer := http.FileServer(http.Dir(wwwDir))
	mux := http.NewServeMux()
	mux.Handle("/", fileServer)

	log.Printf("serving %s at http://%s", wwwDir, addr)
	if err := http.ListenAndServe(addr, mux); err != nil {
		log.Fatal(err)
	}
}

func envOrDefault(name string, fallback string) string {
	value := os.Getenv(name)
	if value == "" {
		return fallback
	}
	return value
}
