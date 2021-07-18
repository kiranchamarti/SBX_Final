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
  inputs = {
    environment           = lower(var.environment)
    application_code      = lower(var.application_code)
    application_name      = lower(var.application_name)
    application_owner     = lower(lookup(var.application_owner, var.application_name, "N/A"))
    application_component = lower(var.application_component)
    sid                   = lower(var.sid)
    provisioner           = lower(var.provisioner)
    delimiter             = var.delimiter
    system_number         = var.system_number 
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

  outputs = {
  # Name                 = length(local.inputs["application_component"]) == 0 ? "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["environment"]}" : "${local.inputs["application_name"]}${local.inputs["delimiter"]}${local.inputs["application_component"]}${local.inputs["delimiter"]}${local.inputs["environment"]}"
    Name                 = length(local.inputs["sid"]) == 0 ? "${local.inputs["application_code"]}${local.inputs["system_number"]}${local.inputs["delimiter"]}${local.inputs["environment"]}" : "${local.inputs["application_code"]}${local.inputs["system_number"]}${local.inputs["delimiter"]}${local.inputs["sid"]}${local.inputs["delimiter"]}${local.inputs["subproject"]}${local.inputs["delimiter"]}${local.inputs["environment"]}"
    Environment          = local.inputs["environment"]
    AppCode              = local.inputs["application_code"]
    ApplicationName      = local.inputs["application_name"]
    ApplicationOwner     = local.inputs["application_owner"]
    ApplicationComponent = local.inputs["application_component"]
    Sid                  = local.inputs["sid"]
    Provisioner          = local.inputs["provisioner"]
    Project              = local.inputs["project"]
    Monitor              = local.inputs["monitor"]
    HANode               = local.inputs["ha_node"]
    BackupPlan           = local.inputs["backup_plan"]
    BusinessStream       = local.inputs["business_stream"]
    CostCenter           = local.inputs["cost_center"]
    Owner                = local.inputs["owner"]
    OwnerEmail           = local.inputs["owner_email"]

  }
}