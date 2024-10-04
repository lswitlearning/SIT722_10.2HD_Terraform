#container-registry


# Create an ECR Container Registry
resource "aws_ecr_repository" "container_registry" {
  name = var.container_registry_name  # ECR repository name from a variable
}
