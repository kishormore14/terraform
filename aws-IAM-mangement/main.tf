terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  userdata = yamldecode(file("./users.yaml")).users

  # Flatten all user-policy pairs into a map keyed by "username::policy"
  user_policy_pairs = {
    for pair in flatten([for user in local.userdata : [for policy in user.policy : {
      user   = user.username
      policy = policy
    }]]) : "${pair.user}::${pair.policy}" => pair
  }
}

resource "aws_iam_user" "users" {
  for_each = toset(local.userdata[*].username)
  name     = each.key
}

resource "aws_iam_user_login_profile" "loginprofile" {
  for_each = aws_iam_user.users
  user     = each.key

  lifecycle {
    ignore_changes = [password_reset_required]
  }
}

resource "aws_iam_user_policy_attachment" "policy_attach" {
  for_each   = local.user_policy_pairs
  user       = each.value.user
  policy_arn = "arn:aws:iam::aws:policy/${each.value.policy}"

  depends_on = [aws_iam_user.users]
}

output "user_policy_pairs" {
  value = local.user_policy_pairs
}