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
aws_region = "us-east-1"
enabled    = true

#Tags and Naming
application_code      = "app"
product               = "s4hana"
application_component = ""
application_name      = "HBX"
subproject            = "SAP"
environment_type      = "SBX"
database_code         = "db"
efs_code              = "efs"
project               = "SAP Dual Landscape"
monitor               = "datadog"
ha_node               = "N/A"
backup_plan           = "weekly"
business_stream       = "ES BS"
cost_center           = "ES CC"
owner                 = "Basis"
owner_email           = "@exactscience.com"


#Networking
vpc_id     = "vpc-031a8812bb9b7c081"
subnet_ids = ["subnet-0fcb269d1434278c5", "subnet-05cab64bce519ddda"]
#dns_zone_name          = ""
customer_default_sg_id = "sg-07c0d91c2a6ee0647"
# vpc_security_group_ids= ""
# Operation System
ami_id  = "ami-0ad8eb5058d37a24f"
#ami_id  = "ami-0fcaa39b2e5005ba8"
ssh_key = "exact-sciences-bootstrap"

default_instance_role = false
iam_instance_role     = "ec2-service-role"
iam_instance_profile  = "ec2-service-instance-profile"

# SAP parameters
sid    = "HBX"
sid_db = "EHX"

high_availability = false

# HANA Database Parameters
hana_is_scale_out  = false
hana_instance_type = "r5.8xlarge"
#root_volume_size                = <defaulted_to_50>
hana_disks_data_storage_type   = "gp2"
hana_disks_logs_storage_type   = "gp2"
hana_disks_backup_storage_type = "st1"
hana_disks_shared_storage_type = "gp2"
#hana_disks_shared_size          = <defaulted_to_512>


hana_disks_usr_sap_storage_type = "gp2"
#hana_disks_usr_sap_storage_size = <defaulted_to_50>
customer_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12"]
# Netweaver Application Servers Parameters
#ascs_instance_type = "r5.large"
as_instance_type   = "m5.4xlarge"
as_instance_count  = 1  
efs_sapmnt         = true
#ascs_root_volume_size       = <defaulted_to_50>
#app_server_root_volume_size = <defaulted_to_50>


