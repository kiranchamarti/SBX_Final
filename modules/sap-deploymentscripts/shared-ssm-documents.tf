module "prepare_logs" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-prepare-sap-installation-logs"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/shared/commands/sap-prepare-logs.yaml")

  tags = module.tags.values
}

module "set_hostname" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-set-hostname"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/shared/commands/sap-hostname.yaml")

  tags = module.tags.values
}


module "install_packages" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-install-sap-packages"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/shared/commands/sap-packages.yaml")

  tags = module.tags.values
}

module "set_netweaver_parameters" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-set-sap-netweaver-parameters"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/shared/commands/sap-netweaver-parameters.yaml")

  tags = module.tags.values
}

module "install_aws_data_provider" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-install-sap-aws-data-provider"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/shared/commands/sap-install-aws-data-provider.yaml")

  tags = module.tags.values
}


module "mount_disks" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-mount-netweaver-disks"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/shared/commands/sap-netweaver-disks.yaml")

  tags = module.tags.values
}

module "add_to_hosts" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-add_to_hosts"
  automation_type = "Command"
  path_to_yaml    = file("${path.module}/scripts/module-automations/shared/commands/sap-add-to-hosts.yaml")

  tags = module.tags.values
}

module "bootstrap_netweaver_instances" {
  source = "../_internal-modules/systems-manager/documents"

  command_name    = "${var.product}-bootstrap-netweaver-instances"
  automation_type = "Automation"
  path_to_yaml = templatefile("${path.module}/scripts/module-automations/shared/automations/sap-netweaver-instance-bootstrap.yaml", {
    DNSPrivateZoneName                 = var.dns_zone_name,
    #NetweaverInstancesList             = jsonencode(concat(var.ascs_instance_ids, var.as_instance_ids))
    NetweaverInstancesList             = jsonencode(concat(var.as_instance_ids))
    EfsFileSystemId                    = var.efs_sapmnt,
    CloudWatchLogGroupName             = module.sap_setup_logs_group.name,
    PrepareLogsDocumentName            = module.prepare_logs.document.name,
    SetHostnameDocumentName            = module.set_hostname.document.name,
    InstallPackagesDocumentName        = module.install_packages.document.name,
    SetParametersDocumentName          = module.set_netweaver_parameters.document.name,
    MountDisksDocumentName             = module.mount_disks.document.name,
    InstallAwsDataProviderDocumentName = module.install_aws_data_provider.document.name,
  })

  tags = module.tags.values
}
