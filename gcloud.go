package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
)

func helloHandler(res http.ResponseWriter, req *http.Request) {
	res.Header().Set(
		"Content-Type",
		"text/html",
	)
	io.WriteString(
		res,
		`<doctype html>
<html>
	<head>
		<title>Gcloud - Hello World</title>
	</head>
	<body>
		Hello World 1 - from GCloud
	</body>
</html>`,
	)
}
func defaultHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, this is the default page for Google")
}
func main() {
	http.HandleFunc("/", defaultHandler)
	http.HandleFunc("/hello", helloHandler)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
		return
	}
}
