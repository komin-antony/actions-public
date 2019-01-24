package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
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
		<title>CLOUD_PROVIDER - Hello World</title>
	</head>
	<body>
		<h1> Hello World 2 - from CLOUD_PROVIDER </h1>
	</body>
</html>`,
	)
}
func defaultHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, this is the default page for CLOUD_PROVIDER")
}
func main() {
	http.HandleFunc("/", defaultHandler)
	http.HandleFunc("/hello", helloHandler)

	portToListen := os.Getenv("PORT")
	if len(portToListen) == 0 {
		portToListen = "8080"
	}

	err := http.ListenAndServe(":"+portToListen, nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
		return
	}
}
