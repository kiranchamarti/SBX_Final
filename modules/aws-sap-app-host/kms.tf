resource "aws_kms_alias" "app_key" {
  name          = "alias/${local.Name}"
  target_key_id = var.target_key_id
}
locals {
   delimiter            = "-"
   system_number        = "01"
   Name                 = length(var.sid) == 0 ? "${var.application_code}${local.system_number}${local.delimiter}${var.environment}" : "${var.application_code}${local.system_number}${local.delimiter}${lower(var.sid)}${local.delimiter}${var.subproject}${local.delimiter}${var.environment}"
 }