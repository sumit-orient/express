resource "aws_ecr_repository" "pearl-ecr" {
  name                 = "pearl-ecr"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}