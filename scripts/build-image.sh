#!/bin/bash

#build-image.sh

# Stop the script if any error occurs
set -e

docker build -t ${ECR_REPOSITORY_NAME}:${GITHUB_SHA} .

echo "Docker images built successfully."