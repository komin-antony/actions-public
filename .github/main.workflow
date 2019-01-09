workflow "New workflow" {
  on = "push"
  resolves = ["Docker Tag"]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@master"
  args = "build -t komony/actions-public ."
}

action "Docker Registry" {
  uses = "actions/docker/login@master"
  needs = ["GitHub Action for Docker"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Tag" {
  uses = "actions/docker/tag@master"
  needs = ["Docker Registry"]
  args = "actions-public kbhai/actions-public"
}
