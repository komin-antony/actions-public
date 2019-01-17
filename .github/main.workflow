workflow "New workflow" {
  on = "push"
  resolves = ["Docker Push"]
}

action "Golang Build" {
  uses = "stefanprodan/gh-actions-demo/actions/golang@master"
  args = "fmt"
}

action "Docker Build" {
  uses = "actions/docker/cli@master"
  needs = ["Golang Build"]
  args = "build -t kbhai/actions:test ."
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["GitHub Action for Docker"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "push kbhai/actions:test"
}
