resource "aws_iam_user" "user1" {
  for_each = toset(var.username)
  name  = "${each.key}_${var.orga}"

  tags = {
    test = "terraform"
  }
}


resource "aws_iam_access_key" "user1" {
  for_each = aws_iam_user.user1
  user  = each.value.name
  status = "Inactive"
}

variable "orga" {
    type = string
    default = "M2i"
}

variable "username" {
  type        = list(any)
  description = "name of created user"
}

/*
output "access_key" {
  value = aws_iam_access_key.user1[0].id
}

output "secret_key" {
  value     = aws_iam_access_key.user1[0].secret
  sensitive = true
}
*/
