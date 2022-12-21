variable "user_names" {
  description = "iam usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}

output "iam_usernames" {
  value = [for name in var.user_names : name]
}