output "local-deployment_id" {
  value       = local.deployment_id
  description = "Deployment Id store in local"
}

output "random-string-result" {
  value       = random_string.suffix.result
  description = "Result of random string"
}

output "demo4-rsa-key" {
  value       = tls_private_key.demo4_rsa
  sensitive   = true
  description = "rsa-keypair from tls_private_key resource"
}

output "local-file-resource" {
  value       = local_file.demo4_id_rsa
  sensitive   = true
  description = "demo4_id_rsa local_file"
}

output "local-file-content" {
  value       = local_file.demo4_id_rsa.content
  sensitive   = true
  description = "Content of local_file"
}

output "local-file-name" {
  value       = local_file.demo4_id_rsa.filename
  description = "file name of the key stored in local"
}

output "demo_4_keypair" {
  value       = aws_key_pair.demo_4_keypair
  description = "AWS demo4 keypair"
}
