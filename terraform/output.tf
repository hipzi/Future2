output "ip_haproxy" {
    value = module.haproxy.droplet_ipv4_address
} 

output "ip_k8s_master" {
    value = module.k8s_master.droplet_ipv4_address
}

output "ip_k8s_master_ha" {
    value = module.k8s_master_ha[*].droplet_ipv4_address
}

output "ip_k8s_node" {
    value = module.k8s_node[*].droplet_ipv4_address
}