workflow "Deploy Web App" {
  on = "push"
  resolves = ["Google Cloud Deploy App"]
}

action "Golang Lint" {
  uses = "stefanprodan/gh-actions-demo/.github/actions/golang@master"
  args = "fmt"
}

action "Docker Build" {
  uses = "actions/docker/cli@master"
  needs = ["Golang Lint"]
  args = "build -f Dockerfile.gcloud -t kbhai/actions:google ."
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["Docker Build"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "push kbhai/actions:google"
}

action "Google Cloud Login" {
  uses = "actions/gcloud/auth@master"
  needs = ["Docker Push"]
  secrets = ["GCLOUD_AUTH"]
}

action "Google Cloud Deploy App" {
  uses = "komony/actions-public/actions/gcloud-kube@master"
  needs = ["Google Cloud Login"]
}
