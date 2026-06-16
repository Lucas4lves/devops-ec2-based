output "instance_iam_profile" {
  value = aws_iam_instance_profile.ssm_profile.id
}

output "security_group_id" {
  value = aws_security_group.ssm.id
}