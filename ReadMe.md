# aws_key_pair configuration with Terraform

## Summary

### Step up aws cli configuration

```aws configure --profile <profile_name>```
Enter Access Key
Enter Secret Access Key
Enter default region
Enter output format

Next, make sure the iam user/role has the required permission policy attached to create 

### Create versions.tf

use aws provider 
- use configurated aws profile
- use aws region as a variable

### Create variables.tf

- define the aws_region variable defaulted to ap-southeast-1

### Create keypair.tf

All the related code block concerning with creation of keypair written in here

- local resource with deployment_name is create
- deployment_name is a combination of ```var.deployment_id``` and random 8 chars w/ speical chars

#### To create random string
- use random_string resource
<br>
**Required Argument: length**

#### Create ssh key

Use tls_private_key (Resource)
It generates a secure private key and encodes it in PEM (RFC 1421) and OpenSSH PEM (RFC 4716) formats. 

- use the resource 
- use rsa algorithm

#### Store ssh private key in local directory

Use local_file (Resource)
Generates a local file with the given content.

Arguments:<br>
content = use the private_key_openssh from tls_private_key.<your-resource-name>

filename = required, string

The path to the file that will be created. Missing parent directories will be created. If the file already exists, it will be overridden with the given content.<br>
**Provisioner**
- provisioner Block

Provisioner to model specific actions on the local machine(local-exec) or on a remote machine in order to prepare servers or other infrastructure objects for service

Then use provisioner's local exec to excute command to change the keyfile permission to 400

#### Create aws_key_pair resource

1) Use count to create resource based on the value of create_aws_keypair

What is count?
count= optional, 
type - number 
Total number of instances of this block.

2) create public_key - (Required) The public key material.

public_key value is the result of tls_private_key.<your-key-name>.public_key_openssh

3) tags
Key-value map of resource tags. 
Tags with matching keys will overwrite those defined at the provider-level.

tags is a merge result of 3 objects
{ Name = "${var.friendly_name_prefix}-keypair" }
{ Name = var.ec2_ssh_keypair_name },
var.common_tags

### define variables used

- deployment_name(string)
- create_ssh_keypair(bool | default false) 
- friendly_name_prefix(string | default "any_string")
- ec2_ssh_keypair_name (string | default "any_string")
- common_tags (map(string) | default {})

### create terraform.tfvars

set the values of variables defined in variables.tf

### Terraform apply

run 
```terraform init```
```terraform fmt```
```terraform validate```
```terraform plan```
```terraform approve```

### Check terraform providers
```terraform providers```
Providers required by configuration:

- provider[registry.terraform.io/hashicorp/aws] 5.67.0
- provider[registry.terraform.io/hashicorp/random]
- provider[registry.terraform.io/hashicorp/tls]
- provider[registry.terraform.io/hashicorp/local]

### Result
total of 4 resources will be created
1) aws_key_pair.demo_4_keypair
2) local_file.demo4_id_rsa
3) random_string.suffix
4) tls_private_key.demo4_rsa

After applying, 
"generated" dir is created with ssh private key inside
key name is the value of file_name argument in the local_file.demo4_id_rsa


In aws console
ec2 keypair resource is created with
- name = deployment_id(name + 8 random chars)-key
- merged tags
  -   App         = "demo4-prereqs"
  -   Environment = "demo4"
  -   Owner       = "wnk"
  -   Name        = overridden by ec2_ssh_keypair_name(ec2_ssh_keypair_name = "wnk-prod-keypair")