resource "digitalocean_domain" "domain" {
   name = var.fqdn
   ip_address = var.ip_address
}