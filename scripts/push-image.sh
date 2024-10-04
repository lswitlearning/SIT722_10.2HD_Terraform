#!/bin/bash

# Push-image.sh

# Stop the script if any error occurs
set -euo pipefail

echo "Tagging and pushing Docker image..."
docker tag ${ECR_REPOSITORY_NAME}:${GITHUB_SHA} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${GITHUB_SHA}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${GITHUB_SHA}

echo "Docker images pushed successfully."