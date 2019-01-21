#!/bin/sh -l

set +x

gcloud container clusters create hello-cluster --num-nodes=1
kubectl run hello-web --image=kbhai/actions:test --port 8080
kubectl get pods
kubectl expose deployment hello-web --type=LoadBalancer --port 80 --target-port 8080
