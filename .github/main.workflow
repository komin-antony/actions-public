workflow "Deploy Web App" {
  on = "push"
  resolves = [
    #"Google Cloud Deploy",
    "Azure Deploy",
    #"Heroku Deploy"
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

# action "Docker Build (GCloud)" {
#   uses = "actions/docker/cli@master"
#   needs = ["Docker Login"]
#   args = "build -f Dockerfile.gcloud -t kbhai/actions:google ."
# }

# action "Docker Push (GCloud)" {
#   uses = "actions/docker/cli@master"
#   needs = ["Docker Build (GCloud)"]
#   args = "push kbhai/actions:google"
# }

# action "Google Cloud Login" {
#   uses = "actions/gcloud/auth@master"
#   secrets = ["GCLOUD_AUTH"]
#   needs = ["Docker Push (GCloud)"]
# }

# action "Google Cloud Deploy" {
#   uses = "komony/actions-public/actions/gcloud-kube@master"
#   needs = ["Google Cloud Login"]
# }

action "Docker Build (Azure)" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "build -f Dockerfile.azure -t kbhai/actions:azure ."
}

action "Docker Push (Azure)" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Build (Azure)"]
  args = "push kbhai/actions:azure"
}

action "Azure Deploy" {
  uses = "actions/azure@master"
  args = "webapp create --resource-group $RESOURCE_GROUP --plan $APP_SERVICE_PLAN --name $WEBAPP_NAME --deployment-container-image-name $CONTAINER_IMAGE_NAME"
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
  env = {
    APP_SERVICE_PLAN = "helloWorldDemoServicePlan"
    CONTAINER_IMAGE_NAME = "kbhai/actions:azure"
    RESOURCE_GROUP = "myLinuxResourceGroup"
    WEBAPP_NAME = "helloWorldWebApp"
  }
}

# action "Heroku Login" {
#   uses = "actions/heroku@master"
#   needs = ["Golang Lint"]
#   args = "container:login"
#   secrets = ["HEROKU_API_KEY"]
# }

# action "Heroku Push" {
#   uses = "actions/heroku@master"
#   needs = ["Heroku Login"]
#   args = "container:push --app $HEROKU_APP web"
#   secrets = ["HEROKU_API_KEY"]
#   env = {
#     HEROKU_APP = "hello-world-gh-action"
#   }
# }

# action "Heroku Deploy" {
#   uses = "actions/heroku@master"
#   needs = ["Heroku Push"]
#   args = "container:release --app $HEROKU_APP web"
#   secrets = ["HEROKU_API_KEY"]
#   env = {
#     HEROKU_APP = "hello-world-gh-action"
#   }
# }
