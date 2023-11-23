provider "aws" {
  region = "us-east-1"  # Update with your preferred region
}

resource "aws_s3_bucket" "amplify_artifacts" {
  bucket = "your-amplify-artifacts-bucket-name"  # Update with a unique bucket name

}




resource "aws_amplify_app" "my_amplify_app" {
  name     = "my-amplify-app"
  repository = "https://github.com/sapkalavinash/myShop-Ecommerce-website.git"  # Update with your GitHub repository URL
  oauth_token = "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"
  environment_variables = {
    key   = "value"
    other = "value"
  }

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        build:
          commands:
            - echo "Build started on `date`"
            - npm install
            - npm run build
      artifacts:
        baseDirectory: public
        files:
          - "**/*"
      cache:
        paths:
          - node_modules/**/*
    EOT
}

resource "aws_amplify_branch" "main_branch" {
  app_id  = aws_amplify_app.my_amplify_app.id
  branch_name = "main"
}
