data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "policy" {
  count = "${var.policy-count == "create" ? 1 : 0}"
  name = var.policy-name
  description = "My test policy"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
    {
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
        ],
        "Resource": "*",
        "Effect": "Allow"
    }
  ]

}
EOT



}


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterAutoScalerPolicy" {

  #policy_arn =  "${var.policy-count}" == "create" ? aws_iam_policy.policy[0].arn : "arn:aws:iam::119276831673:policy/policy-create"
  policy_arn =  "${var.policy-count}" == "create" ? aws_iam_policy.policy[0].arn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.policy-name}"
  
  role = aws_iam_role.role.name
}


