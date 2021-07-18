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

# Generic variables
variable "aws_region" {
  description = "(Required) AWS Region to execute deployment to"
}
variable "enabled" {
  default     = true
  description = "(Optional) Enable the provisioning of resources of the module or not"
  type        = bool
}
# Tags
variable "application_code" {
  description = "(Required) The unique application code for resource naming"
  type        = string
}
variable "application_name" {
  description = "(mandatory) The id of the system being provisioned, ex. 'HBX', 'EHP', 'H1D' etc."
  type        = string
}
variable "product" {
  description = "(Optional) The name of the application being provisioned, ex. 'datamart', 'ecc', 's4hana', etc."
  type        = string
}
variable "environment_type" {
  description = "(Required) Environment type of SAP Netweaver system, e.x. 'dev', 'test', 'prod'"
  type        = string
}
#Networking
variable "vpc_id" {
  description = "(Required) VPC to deploy infrastructure to"
  type        = string
}
variable "subnet_ids" {
  description = "(Required) List of subnets for instance distribution"
  type        = list(string)
}
variable "dns_zone_name" {
  default = "(Optional) The name of Route53 Private DNS zone. If not provided - DNS record will not be created"
  type    = string
}
variable "customer_default_sg_id" {
  description = "(Optional) List of preexisting security groups to be attached to the instance. The required security groups are created automatically, this is just for mandatory default ones"
  default     = []
}
variable "customer_cidr_blocks" {
  default     = []
  description = "(Optional) The CIDR blocks to allow end-user connectivity from"
  type        = list(string)
}
variable "subproject" {
  type        = string
  description = "Name of the subproject this instance belong to"
  default     = "SAP"
}
# Operation System
variable "ami_id" {
  description = "(Required) The AMI id for the underlying OS"
  type        = string
}
variable "ssh_key" {
  description = "(Optional) The key pair name for the instances. If not provided - you can use SSM session manager for console access"
  default     = ""
  type        = string
}
variable "user_data" {
  description = "(Optional) The user data script for the instance. If none provisioned - default one will be used to install AWS CLI and SSM agent"
  default     = ""
  type        = string
}
# Security
variable "kms_key_arn" {
  default = ""
  type    = string
}
variable "default_instance_role" {
  description = "(Optional) Flag to define whether default instance role should be created"
  default     = true
  type        = bool
}
variable "iam_instance_role" {
  description = "(Optional) The IAM role name to be attached to instance profile"
  default     = ""
  type        = string
}
variable "iam_instance_profile" {
  description = "(Optional) The IAM profile attached to be related to the role"
  default     = ""
  type        = string
}
# SAP parameters
variable "sid" {
  description = "(Required) The System id for the SAP Netweaver system"
  type        = string
}
variable "sid_db" {
  description = "(Required) The System id for the SAP Database system"
  type        = string
}
variable "high_availability" {
  default     = false
  description = "If true provision second instances for HANA and ASCS"
  type        = bool
}
# HANA Database Parameters
variable "enable_ha" {
  default     = false
  description = "(Optional) Defines how many instances should be deployed"
  type        = bool
}
variable "hana_is_scale_out" {
  default     = false
  description = "(Optional) Defines whether Shared disk should be create as an EFS file system"
  type        = bool
}
variable "hana_scale_out_node_count" {
  description = "(Required, if hana_is_scale_out = false) Defines how many nodes required for scale-out scenario"
  default     = 3
  type        = number
}
variable "hana_instance_type" {
  description = "(Required) Identifies the instance types to be used for HANA. Should be from the list of certified instances, since the disk sizing is done based on this"
  type        = string
}
variable "root_volume_size" {
  default     = 300
  description = "(Optional) Size in GBs for the root volumes of the instances"
  type        = number
}
variable "hana_disks_data_storage_type" {
  default     = "gp2"
  description = "(Optional) EBS Volume type for hana data volumes. Can be gp2 or io1"
  type        = string
}
variable "hana_disks_logs_storage_type" {
  default     = "gp2"
  description = "(Optional) EBS Volume type for hana log volumes. Can be gp2 or io1"
  type        = string
}
variable "hana_disks_backup_storage_type" {
  default     = "st1"
  description = "(Optional) EBS Volume type for hana backup volumes."
  type        = string
}
variable "hana_disks_shared_storage_type" {
  default     = "gp2"
  description = "(Optional) EBS Volume type for hana shared volumes."
  type        = string
}
variable "hana_disks_shared_size" {
  default     = "512"
  description = "(Optional) Size in GBs for the hana shared volumes of the instances"
  type        = string
}
variable "hana_disks_usr_sap_storage_type" {
  default     = "gp2"
  description = "(Optional) EBS Volume type for hana /usr/sap volumes. "
  type        = string
}
variable "hana_disks_usr_sap_storage_size" {
  default     = 50
  description = "(Optional) Size in GBs for the /usr/sap volumes of the instances"
  type        = number
}
# Netweaver Application Servers Parameters
variable "ascs_instance_type" {
  default     = "m5.xlarge"
  description = "The instance type for SAP Central Services"
  type        = string
}
variable "as_instance_type" {
  default     = "m5.xlarge"
  description = "The instance type for SAP Application Servers"
  type        = string
}
variable "as_instance_count" {
  default     = 1
  description = "Number of application server instances to be provisioned"
  type        = number
}
variable "efs_sapmnt" {
  default     = true
  description = "(Optional) Flag to define whether EFS File Systems should be provisioned for /sapmnt"
  type        = bool
}
variable "efs_name" {
  default = "dir_sapmnt"
  type    = string
}
variable "sapmnt_volume_size" {
  default     = 0
  description = "(Optional) Size in GBs for the /sapmnt volume. Use it only for non-EFS scenario. Not provisioned if value = 0"
  type        = number
}
variable "ascs_root_volume_size" {
  default     = 300
  description = "(Optional) Size in GBs for the root volumes of the instances"
  type        = number
}
variable "app_server_root_volume_size" {
  default     = 300
  description = "(Optional) Size in GBs for the root volumes of the instances"
  type        = number
}
/*variable "vpc_security_group_ids" {
type = string
description = "(Optional) Security groups for Ec2 instances"
}
*/

variable "database_code" {
  description = "(Required) The unique application code for resource naming"
  type        = string
}
variable "efs_code" {
  description = "(Required) The unique efs code for resource naming"
  type        = string
}
variable "project" {
  description = "(Required) The unique application code for resource naming"
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
variable "application_component" {
  description = "(Required) The unique application component for resource naming"
}
