FROM gcr.io/cloud-builders/kubectl:latest

LABEL "com.github.actions.name"="gcloud-kubectl-commands"
LABEL "com.github.actions.description"="Run kubectl commands"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="green-dark"

LABEL "name"="automerge"
LABEL "version"="1.0.0"
LABEL "repository"="http://github.com/komony/actions-public"
LABEL "homepage"="http://github.com/komony"
LABEL "maintainer"="komony <kominbhai@gmail.com>"

RUN gcloud components install kubectl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
