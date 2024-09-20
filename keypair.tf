/* ------------------------------------------------------------------------ */
/*                             Common Resource                              */
/* ------------------------------------------------------------------------ */

locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

/* ------------------------------------------------------------------------ */
/*                             SSH Key                                      */
/* ------------------------------------------------------------------------ */

resource "tls_private_key" "demo4_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "demo4_id_rsa" {
  content  = tls_private_key.demo4_rsa.private_key_openssh
  filename = "${path.root}/generated/${local.deployment_id}_key.pem"

  provisioner "local-exec" {
    command = "chmod 400 ${path.root}/generated/${local.deployment_id}_key.pem"
  }
}

/* ------------------------------------------------------------------------ */
/*                                     aws_key_pair                         */
/* ------------------------------------------------------------------------ */

resource "aws_key_pair" "demo_4_keypair" {
  count = var.create_ssh_keypair ? 1 : 0

  key_name   = "${local.deployment_id}-key"
  public_key = tls_private_key.demo4_rsa.public_key_openssh

  tags = merge(
    { Name = "${var.friendly_name_prefix}-keypair" },
    { Name = var.ec2_ssh_keypair_name },
    var.common_tags
  )
}
