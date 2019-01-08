FROM golang:latest

ADD main.go /go/main.go

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-s -w' /go/main.go

ENTRYPOINT /go/main

# http server listens on port 8080.
EXPOSE 8080