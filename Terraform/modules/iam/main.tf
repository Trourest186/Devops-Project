# Create IAM user "trourest"
module "iam_user" {
  version = "5.30.2"
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name          = "trourest"
  force_destroy = true  # Allow destroying the user without additional confirmation
  pgp_key = "keybase:tgpham26gmailcom"

  create_iam_access_key = true
  password_reset_required = false
  password_length = 18
  
  tags = {
    Name = "Giang"
  }
  # You can add additional configurations for the user here if needed
}

module "iam_group_with_policies" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name = "Admin-trourest"

  group_users = [
    "trourest"
  ]

  attach_iam_self_management_policy = true

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/IAMUserChangePassword",
  ]

}