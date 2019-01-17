workflow "New workflow" {
  on = "push"
  resolves = ["Docker Push"]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@master"
  args = "build -t kbhai/actions:test ."
}

action "Docker Registry" {
  uses = "actions/docker/login@master"
  needs = ["GitHub Action for Docker"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Registry"]
  args = "push kbhai/actions:test"
}
