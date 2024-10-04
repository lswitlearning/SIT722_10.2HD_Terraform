#!/bin/bash

# deploy.sh

# Stop the script if any error occurs
set -e

# Replace environment variables and create a temporary deployment file
envsubst < scripts/deploy.yaml > scripts/deploy-withenv.yaml

# Use kubectl to deploy to AKS
kubectl apply -f scripts/deploy-withenv.yaml
