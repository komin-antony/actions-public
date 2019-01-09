workflow "New workflow" {
  on = "push"
  resolves = ["Docker Tag"]
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["GitHub Action for Docker"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Build & Push" {
  uses = "actions/docker/cli@master"
  args = ["build -t komony/actions-public .", "push komony/actions-public"]
}
