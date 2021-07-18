resource "aws_kms_alias" "ascs_key" {
  name          = "alias/${local.Name}"
  target_key_id = var.target_key_id
}
locals {
   delimiter             = "-"
   Name                 = length(var.sid) == 0 ? "${var.application_code}${local.delimiter}${var.environment}" : "${var.application_code}${local.delimiter}${var.sid}${local.delimiter}${var.subproject}${local.delimiter}${var.environment}"
 }