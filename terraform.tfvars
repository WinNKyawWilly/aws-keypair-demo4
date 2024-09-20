deployment_name      = "wnk-ec2"

create_ssh_keypair   = true

friendly_name_prefix = "wnk"

ec2_ssh_keypair_name = "wnk-demo-keypair"

common_tags = {
  App         = "demo4-prereqs"
  Environment = "demo4"
  Owner       = "wnk"
}
