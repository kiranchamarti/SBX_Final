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
#Control Variable
variable "trigger_automatically" {
  default = false
}

#Installation binary sources
variable "binaries_bucket_name" {}
variable "binaries_key_arn" {}
variable "binaries_folder" {
  default = ""
}

#Infrastructure Details
variable "hana_instance_ids" {
  type = list
}
/*
variable "ascs_instance_ids" {}
*/
variable "as_instance_ids" {
  type = list
}

variable "dns_zone_name" {}

variable "efs_sapmnt" {
  default = "N/A"
}

# Security
variable "kms_key_arn" {}

# Software Details 
variable "subproject" {
  type        = string
  description = "Name of the subproject this instance belong to"
}

# Tags
variable "environment" {}
variable "application_code" {}
variable "application_name" {}
variable "sid" {}
variable "project" {}
variable "monitor" {}
variable "ha_node" {}
variable "backup_plan" {}
variable "business_stream" {}
variable "cost_center" {}
variable "owner" {}
variable "owner_email" {}
variable "product"{}
