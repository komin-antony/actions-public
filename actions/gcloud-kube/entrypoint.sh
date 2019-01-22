#!/bin/bash -l

gcloud config set project qualified-smile-226721
gcloud config set compute/zone us-east4-a

gcloud container clusters delete hello-cluster --quiet
gcloud container clusters create hello-cluster --num-nodes=1
kubectl run hello-web --image=kbhai/actions:google --port 443
kubectl expose deployment hello-web --type=LoadBalancer --port 443 --target-port 443