# terraform {
#    backend "remote" {
#         hostname = "app.terraform.io"
#         organization = "felix_personal"

#         workspaces {
#           name = "getting-started"
#         }
#       }

#     required_providers {
#       aws = {
#         source  = "hashicorp/aws"
#         version = "5.35.0"
#       }
#     }
#   }



# in tf cloud need to set AWS env vars
# provider "aws" {
#   region = "eu-west-2"
# }

# For local state handling, this file is:
terraform {

  # required_version = ">=1.7.2, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-2"
  profile = "personal"
}


# provider "aws" {
#   region = "eu-west-2"
#   access_key = "AKIA6E3U7R2FUYMBZG7K"
#   secret_key = "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"
# }