workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Action for Google Cloud-1"]
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

action "Google Cloud Login" {
  uses = "actions/gcloud/auth@master"
  needs = ["Docker Push"]
  secrets = ["GCLOUD_AUTH"]
}

action "GitHub Action for Google Cloud" {
  uses = "actions/gcloud/cli@master"
  needs = ["Google Cloud Login"]
  args = "container clusters create hello-cluster --num-nodes=1"
}

action "GitHub Action for Google Cloud-1" {
  uses = "actions/gcloud/cli@master"
  needs = ["GitHub Action for Google Cloud"]
  args = "kubectl run hello-web --image=kbhai/actions:test --port 8080"
}
