/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: MIT-0
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

locals {
  instance_policy_name = "${lower(var.application_code)}-${lower(var.application_name)}-sap_hana_instance_default_policy-${lower(var.environment)}"
  instance_role_name   = "${lower(var.application_code)}-${lower(var.application_name)}-sap_hana_instance_default_role-${lower(var.environment)}"
}

data "aws_iam_policy_document" "instance_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "instance_policy" {
  //   statement {
  //     effect = "Allow"
  //     actions = [
  //       "s3:ListBucket",
  //       "s3:GetObject",
  //       "kms:Decrypt"
  //     ]
  //   resources = [
  //       var.binaries_bucket_arn,
  //       "${var.binaries_bucket_arn}/*"
  //     ]
  //   }
  //   statement {
  //     effect = "Allow"
  //     actions = [
  //       "ssm:SendCommand",
  //       "ssm:DescribeAutomationExecutions",
  //       "ssm:DescribeAutomationStepExecutions",
  //       "ssm:GetAutomationExecution",
  //       "ssm:StartAutomationExecution",
  //       "ssm:StopAutomationExecution",
  //       "ssm:SendAutomationSignal"
  //     ]
  //     resources = [
  //       "arn:aws:ssm:*:*:automation-definition/*:*",
  //       "arn:aws:ssm:*:*:document/*"
  //     ]
  # condition {
  #   test     = "StringLike"
  #   variable = "ssm:resourceTag/appCode"
  #   values   = [var.tags["appCode"]]
  # }
  //   }
  //   statement {
  //     effect = "Allow"
  //     actions = [
  //       "ssm:SendCommand",
  //       "ssm:DescribeAutomationExecutions",
  //       "ssm:DescribeAutomationStepExecutions",
  //       "ssm:GetAutomationExecution",
  //       "ssm:StartAutomationExecution",
  //       "ssm:StopAutomationExecution",
  //       "ssm:SendAutomationSignal",
  //       "ssm:UpdateInstanceInformation"
  //     ]
  //     resources = [
  //       "arn:aws:ec2:*:*:instance/*",
  //     ]
  # condition {
  #   test     = "StringLike"
  #   variable = "ssm:resourceTag/appCode"
  #   values   = [var.tags["appCode"]]
  # }
  //   }
  //   statement {
  //       actions = [
  //         "ssm:ListCommands",
  //         "ssm:ListCommandInvocations",
  //         "ssm:GetDocument",
  //         "ssm:ListDocuments",
  //         "ssm:PutParameter"
  //       ]
  //       resources = [
  //           "*"
  //       ]
  //   }
  //   statement{
  //     actions = [
  //       "s3:DeleteObject", 
  //       "s3:GetObject", 
  //       "s3:PutObject",
  //       "s3:ListBucket"
  //     ]
  //       resources = [
  //         "arn:aws:s3:::${var.application_code}*/*"
  //       ]
  //   }
  #Statements for KMS
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = [var.kms_key_arn]
  }
}

module "default_instance_role" {
  source = "../_internal-modules/security/iam"

  enabled = var.default_instance_role

  policy_name = local.instance_policy_name
  policy      = data.aws_iam_policy_document.instance_policy.json

  aws_managed_policies = ["arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  role_name            = local.instance_role_name

  assume_role_policy = data.aws_iam_policy_document.instance_trust.json

  tags = merge(module.tags.values)
}