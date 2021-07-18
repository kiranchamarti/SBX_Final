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

resource "aws_kms_key" "efs_key" {
  key_usage = "ENCRYPT_DECRYPT"
}

module "sap_efs" {
  source  = "./modules/aws-sap-netweaver-efs"
  enabled = var.enabled

  kms_key_arn   = aws_kms_key.efs_key.arn
  target_key_id = aws_kms_key.efs_key.id

  aws_region = var.aws_region

  subnet_ids         = var.subnet_ids
  vpc_id             = var.vpc_id
  sid                = var.sid
  security_group_ids = module.sap_app_host.security_group_id
  name               = var.efs_name

  application_code = lower(var.efs_code)
  environment      = lower(var.environment_type)
  application_name = lower(var.application_name)
  subproject       = lower(var.subproject)
  project          = var.project
  monitor          = var.monitor
  ha_node          = var.ha_node
  backup_plan      = var.backup_plan
  business_stream  = var.business_stream
  cost_center      = var.cost_center
  owner            = var.owner
  owner_email      = var.owner_email
  efs_code         = var.efs_code
}

resource "aws_kms_key" "db_key" {
  key_usage = "ENCRYPT_DECRYPT"
}

module "hana_host" {
  source = "./modules/aws-sap-hana-host"

  instance_count = 1  
  instance_type  = var.hana_instance_type

  is_scale_out = var.hana_is_scale_out
  #ssh_key = var.ssh_key
  enabled = var.enabled
  ami_id  = var.ami_id

  kms_key_arn   = aws_kms_key.db_key.arn
  target_key_id = aws_kms_key.db_key.id
  ssh_key       = var.ssh_key
  vpc_id        = var.vpc_id
  sid           = var.sid_db

  subnet_ids             = var.subnet_ids
  dns_zone_name          = var.dns_zone_name
  customer_cidr_blocks   = var.customer_cidr_blocks
  customer_default_sg_id = var.customer_default_sg_id

  iam_instance_role    = var.default_instance_role ? "" : var.iam_instance_role
  iam_instance_profile = var.iam_instance_profile

  # Tags
  application_code      = lower(var.database_code)
  application_component = lower(var.application_component)
  database_code         = lower(var.database_code)
  environment           = lower(var.environment_type)
  application_name      = lower(var.application_name)
  subproject            = lower(var.subproject)
  project               = var.project
  monitor               = var.monitor
  ha_node               = var.ha_node
  backup_plan           = var.backup_plan
  business_stream       = var.business_stream
  cost_center           = var.cost_center
  owner                 = var.owner
  owner_email           = var.owner_email
}

resource "aws_kms_key" "app_key" {
  key_usage = "ENCRYPT_DECRYPT"
}

module "sap_app_host" {
  source  = "./modules/aws-sap-app-host"
  enabled = var.enabled

  instance_count = var.as_instance_count

  ami_id                  = var.ami_id
  kms_key_arn             = aws_kms_key.app_key.arn
  target_key_id           = aws_kms_key.app_key.id
  ssh_key                 = var.ssh_key
  vpc_id                  = var.vpc_id
  subnet_ids              = var.subnet_ids
  dns_zone_name           = var.dns_zone_name
  customer_default_sg_ids = var.customer_default_sg_id
  efs_security_group_id   = module.sap_efs.security_group_id

  instance_type        = var.as_instance_type
  iam_instance_role    = var.default_instance_role ? "" : var.iam_instance_role
  iam_instance_profile = var.iam_instance_profile

  # Tags
  application_code = lower(var.application_code)
  environment      = lower(var.environment_type)
  application_name = lower(var.application_name)
  subproject       = lower(var.subproject)
  project          = var.project
  monitor          = var.monitor
  ha_node          = var.ha_node
  backup_plan      = var.backup_plan
  business_stream  = var.business_stream
  cost_center      = var.cost_center
  owner            = var.owner
  owner_email      = var.owner_email
  # SAP
  sid = var.sid
}

module "sap_deployment" {
  source               = "./modules/sap-deploymentscripts"
  binaries_bucket_name = "arn:aws:s3:::kkc-misc"
  binaries_key_arn     = var.kms_key_arn
  binaries_folder      = ""
  hana_instance_ids    = module.hana_host.instance_ids
  as_instance_ids      = module.sap_app_host.instance_ids
  #ascs_instance_ids    = module.sap_ascs_host.instance_ids
  kms_key_arn      = var.kms_key_arn
  dns_zone_name    = var.dns_zone_name
  application_code = lower(var.application_code)
  environment      = lower(var.environment_type)
  application_name = lower(var.application_name)
  sid              = var.sid
  project          = var.project
  subproject       = var.subproject
  product          = var.product
  monitor          = var.monitor
  ha_node          = var.ha_node
  backup_plan      = var.backup_plan
  business_stream  = var.business_stream
  cost_center      = var.cost_center
  owner            = var.owner
  owner_email      = var.owner_email
}

