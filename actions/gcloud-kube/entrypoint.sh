#!/bin/bash -l

set +x

gcloud config set project qualified-smile-226721
gcloud config set compute/zone us-east4-a

string=$(gcloud container clusters create hello-cluster --num-nodes=1)
if [[ $string == *"Error"* ]]; then
  gcloud container clusters get-credentials hello-cluster
  kubectl set image deployment/hello-web hello-web=kbhai/actions:google
else
  kubectl run hello-web --image=kbhai/actions:google --port 443
  kubectl expose deployment hello-web --type=LoadBalancer --port 443 --target-port 443
fi


