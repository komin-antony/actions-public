workflow "Docker Deploy" {
  on = "push"
  resolves = ["Docker Push"]
}

action "Docker Build" {
  uses = "actions/docker/cli@master"
  args = "build -t kbhai/actions:test ."
}

action "Docker Login" {
  needs = ["Docker Build"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Push" {
  needs = ["Docker Push"]
  uses = "actions/docker/cli@master"
  args = "push kbhai/actions:test"
}

