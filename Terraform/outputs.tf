output "security_subnet" {
  value = module.vpc.aws_vpc
}

output "ip_private_master" {
  description = "Private address of Master"
  value = module.ec2.ip_private_master
}

output "ip_public_master" {
  description = "Public address of Master"
  value = module.ec2.ip_public_master
}

output "ip_private_worker" {
  description = "Private address of Master"
  value = module.ec2.ip_private_worker
}

output "ip_public_worker" {
  description = "Public address of Master"
  value = module.ec2.ip_public_worker
}

output "ip_public_jenkins" {
  description = "Public address of Jenkins"
  value = module.ec2.ip_public_jenkins
}

output "ip_public_ansible" {
  description = "Public address of Ansible"
  value = module.ec2.ip_public_ansible
}

output "key_pair" {
  description = "Private key in PEM format"
  value       = tls_private_key.rsa.public_key_pem
  sensitive = true
}