#!/bin/bash -l

gcloud config set project $PROJECT_NAME
gcloud config set compute/zone $PROJECT_ZONE

gcloud container clusters get-credentials $PROJECT_CLUSTER
kubectl set image deployment/hello-web hello-web=kbhai/actions:google-$GITHUB_SHA
