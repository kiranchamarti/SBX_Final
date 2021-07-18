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

variable "aws_region" {}

variable "vpc_id" {}

variable "subnet_ids" {
}

variable "name" {}

variable "enabled" {
  default = false
}

variable "kms_key_arn" {
  description = "(Optional) KMS Key to be used for EBS volume encryption. If none is provisioned - volumes will not be encrypted"
  default     = ""
}
variable "security_group_ids" {}

#Tags
variable "environment" {
  description = "(Required) Environment type for HANA system, e.x. 'dev', 'test', 'prod'"
}
variable "application_name" {
  description = "(Required) The name of the application being provisioned, ex. 'datamart', 'ecc', 's4hana', etc."
}
variable "application_code" {
  description = "(Required) The unique application code for resource naming"
  default = "efs"
}
variable "subproject" {
  description = "(Required) The name of the subproject, ex. 'SAP' etc."
  type        = string
}
variable "project" {
  description = "(Required) The name of the project"
  type        = string
}

variable "monitor" {
  description = "(Required) The tool to monitor the resources"
  type        = string
}

variable "ha_node" {
  description = "(Required) The node incase the application is cluster"
  type        = string
}

variable "backup_plan" {
  description = "(Required) Application backup procedure"
  type        = string
}

variable "business_stream" {
  description = "(Required) Exact Science business unit for SAP applications"
  type        = string
}

variable "cost_center" {
  description = "(Required) Exact Science cost center for SAP applications"
  type        = string
}

variable "owner" {
  description = "(Required) Application support team "
  type        = string
}

variable "owner_email" {
  description = "(Required) Application support team email id "
  type        = string
}

variable "target_key_id" {
type = string
}

variable "sid" {
  description = "(Required) The System id for the Application system"
}

variable "efs_code" {
  description = "(Required) Code for EfS file system"
}