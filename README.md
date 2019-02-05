# GitHub Actions Demo

Simple Golang Web App bundled as a Docker Image to demo GitHub Actions

On push, the following actions will be run (in parallel):
- Build the web app
- Push Docker images
- Deploy to Heroku, Google Cloud & Azure
- Deploy to AWS (pending)
