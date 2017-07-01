//  Create a role which OpenShift instances will assume.
//  This role has a policy saying it can be assumed by ec2
//  instances.
resource "aws_iam_role" "openshift-instance-role" {
  name = "openshift-instance-role"

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


//  Create a instance profile for the role.
resource "aws_iam_instance_profile" "openshift-instance-profile" {
  name  = "openshift-instance-profile"
  role = "${aws_iam_role.openshift-instance-role.name}"
}
