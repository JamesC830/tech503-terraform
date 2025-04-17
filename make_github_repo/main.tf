# Create a github repo

provider "github" {
  token = var.PAT
  owner = var.username
}

resource "github_repository" "terraform-made-this-repo" {
  name        = "terraform-made-this-repo"
  description = "This repo was created with Terraform"
  visibility  = "public"

  has_issues  = true
  has_wiki    = false
  auto_init   = true
}