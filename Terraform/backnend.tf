# Save state file into S3 bucket
# terraform {
#   backend "s3" {
#     bucket = "trourest"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     profile = "default"
#   }
# For State Locking
##dynamodb_table = "terraform-dev-state-table" 
# }