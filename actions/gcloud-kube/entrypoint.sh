#!/bin/bash -l

set +x

gcloud config set project qualified-smile-226721
gcloud config set compute/zone us-east4-a

gcloud container clusters get-credentials hello-cluster
string=$(kubectl get deployment hello-web)
if [[ $string == *"Error"* ]]; then
  gcloud container clusters create hello-cluster --num-nodes=1
  kubectl run hello-web --image=kbhai/actions:test --port 8080
  kubectl expose deployment hello-web --type=LoadBalancer --port 80 --target-port 8080
else
  kubectl set image deployment/hello-web hello-web=kbhai/actions:test
fi


