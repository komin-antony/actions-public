workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Action for Google Cloud SDK auth"]
}

action "Golang Lint" {
  uses = "stefanprodan/gh-actions-demo/.github/actions/golang@master"
  args = "fmt"
}

action "Docker Build" {
  uses = "actions/docker/cli@master"
  needs = ["Golang Lint"]
  args = "build -t kbhai/actions:test ."
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["Docker Build"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "push kbhai/actions:test"
}

action "GitHub Action for Google Cloud SDK auth" {
  uses = "actions/gcloud/auth@master"
  needs = ["Docker Push"]
  secrets = ["GCLOUD_AUTH"]
}
