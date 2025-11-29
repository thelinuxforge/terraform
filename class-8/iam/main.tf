provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_user" "myUser" {
    name = "LinuxForge-1"
}

resource "aws_iam_policy" "customPolicy" {
    name = "EC2"
    policy = <<EOF

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:GetResourcePolicy",
                "cloudfront:ListCloudFrontOriginAccessIdentities",
                "cloudfront:ListFunctions"   
            ],
            "Resource": "*"
        }
    ]
}
    EOF
  
}

resource "aws_iam_policy_attachment" "policyBind" {
    name = "attachment"
    users = [aws_iam_user.myUser.name]
    policy_arn = aws_iam_policy.customPolicy.arn
}