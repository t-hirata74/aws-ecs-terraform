resource "aws_ecr_repository" "ecr_repository" {
  name                 = local.app
  image_tag_mutability = "IMMUTABLE" # イメージに付与されるタグを イミュータブル、つまり、イメージタグの上書きを禁止する設定 です
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true # プッシュしたイメージに脆弱性スキャンを施すという設定
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repository.name

  # ECR レポジトリのライフサイクルポリシーの設定
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}