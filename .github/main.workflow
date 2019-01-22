workflow "Deploy Web App" {
  on = "push"
  resolves = [
    "Google Cloud Deploy App",
    "Docker Push (Heroku)",
  ]
}

action "Golang Lint" {
  uses = "stefanprodan/gh-actions-demo/.github/actions/golang@master"
  args = "fmt"
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = ["Golang Lint"]
}

action "Docker Build (GCloud)" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "build -f Dockerfile.gcloud -t kbhai/actions:google ."
}

action "Docker Push (GCloud)" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Build (GCloud)"]
  args = "push kbhai/actions:google"
}

action "Google Cloud Login" {
  uses = "actions/gcloud/auth@master"
  secrets = ["GCLOUD_AUTH"]
  needs = ["Docker Push (GCloud)"]
}

action "Google Cloud Deploy App" {
  uses = "komony/actions-public/actions/gcloud-kube@master"
  needs = ["Google Cloud Login"]
}

action "Docker Build (Heroku)" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "build -f Dockerfile.gcloud -t kbhai/actions:heroku ."
}

action "Docker Push (Heroku)" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Build (Heroku)"]
  args = "push kbhai/actions:heroku"
}
