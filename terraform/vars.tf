# DigitalOcean

variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "do_region" {
  type = string
  description = "DigitalOcean Region of Droplet"
}

variable "droplet_size_1vcpu_1gb" {
  description = "DigitalOcean Droplet Size 1 Cpu 1 GB RAM"
}

variable "droplet_size_2vcpu_2gb" {
  description = "DigitalOcean Droplet Size 2 Cpu 2 GB RAM"
}

variable "droplet_size_4vcpu_8gb" {
  description = "DigitalOcean Droplet Size 4 Cpu 8 GB RAM"
}

variable "ssh_fingerprint" {
  type        = string
  description = "SSH key fingerprint"
}

variable "domain_haproxy" {
  type        = string
  description = "DigitalOcean Domain for Haproxy Server"
}

# Ansible

variable "ansible_path" {
  type        = string
  description = "Ansible Path" 
}

variable "ansible_roles_path" {
  type        = string
  description = "Ansible Roles Path" 
}

variable "ansible_host_key_checking" {
  type        = bool
}

# Key

variable "pub_key" {
  type        = string
  description = "Path to your public SSH key"
}

variable "pvt_key" {
  type        = string
  description = "Path to your private SSH key"
}