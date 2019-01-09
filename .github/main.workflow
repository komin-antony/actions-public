workflow "Docker Deploy" {
  on = "push"
  resolves = ["GitHub Action for Docker"]
}

action "Docker Registry" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Registry"]
  args = "build -t komony/actions-public ."
}
