resource "aws_iam_role" "ecr-role" {
  name = "ecr-role"

  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}

resource "aws_iam_policy" "ecr-role-policy" {
  name        = "ecr-role-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:*",
        "cloudtrail:LookupEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.ecr-role.name}"
  policy_arn = "${aws_iam_policy.ecr-role-policy.arn}"
}


resource "aws_iam_instance_profile" "profile" {
  role = aws_iam_role.ecr-role.name
}