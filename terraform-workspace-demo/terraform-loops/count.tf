# resource "aws_iam_user" "users" {
#     count = length(var.user_names)
#     name = var.user_names[count.index]
# }

# variable "user_names"{
#     description = "IAM usernames"
#     type = list(string)
#     default = ["user1","user2","user3"]
# }