# AWS Key Pair Configuration with Terraform

This repository contains Terraform configurations to create an `aws_key_pair` resource with tags for use with EC2 instances.

## Overview

- Creates an AWS key pair with a unique name using a random string
- Supports multiple tags
- Saves the private key on the local device
- Uses Terraform to manage the infrastructure

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed

## Setup

1. Configure AWS CLI:
   ```
   aws configure --profile <profile_name>
   ```
   Enter your Access Key, Secret Access Key, default region, and output format.

2. Ensure the IAM user/role has the required permissions to create resources.

## File Structure

- `versions.tf`: Defines the required providers and their versions
- `variables.tf`: Declares input variables
- `keypair.tf`: Contains the main logic for creating the key pair
- `terraform.tfvars`: Sets values for the defined variables

## Key Components

### Random String Generation

Uses `random_string` resource to create a unique identifier for the key pair.

### SSH Key Creation

Utilizes `tls_private_key` resource to generate a secure private key.

### Local Storage of Private Key

Employs `local_file` resource to save the private key on the local machine with appropriate permissions.

### AWS Key Pair Resource

Creates the `aws_key_pair` resource with the generated public key and specified tags.

## Variables

- `deployment_name` (string)
- `create_ssh_keypair` (bool, default: false)
- `friendly_name_prefix` (string, default: "any_string")
- `ec2_ssh_keypair_name` (string, default: "any_string")
- `common_tags` (map(string), default: {})

## Usage

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Format and validate the configuration:
   ```
   terraform fmt
   terraform validate
   ```

3. Plan the changes:
   ```
   terraform plan
   ```

4. Apply the changes:
   ```
   terraform apply
   ```

## Providers

- `hashicorp/aws` (5.67.0)
- `hashicorp/random`
- `hashicorp/tls`
- `hashicorp/local`

## Results

After applying the configuration:

- A `generated` directory is created containing the SSH private key
- An EC2 key pair resource is created in AWS with the specified name and tags

## Notes

- The key name format is: `<deployment_id>-<8_random_chars>-key`
- Tags are merged from multiple sources, with `ec2_ssh_keypair_name` taking precedence for the `Name` tag

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or find any bugs.

![image](https://github.com/user-attachments/assets/ec266349-9282-472e-a304-b3f71d7a3135)
