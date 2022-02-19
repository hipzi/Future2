module "haproxy" {
    source = "./modules/droplet"

    droplet_name       = "haproxy"
    droplet_image      = data.digitalocean_image.centos.image
    droplet_size       = var.droplet_size_1vcpu_1gb
    do_region          = var.do_region
    ssh_keys           = var.ssh_fingerprint
}

module "k8s_master" {
    source = "./modules/droplet"

    droplet_name       = "master"
    droplet_image      = data.digitalocean_image.centos.image
    droplet_size       = var.droplet_size_2vcpu_2gb
    do_region          = var.do_region
    ssh_keys           = var.ssh_fingerprint
}

module "k8s_master_ha" {
    source = "./modules/droplet"
    count  = 2

    droplet_name       = "master-ha-${count.index + 1}"
    droplet_image      = data.digitalocean_image.centos.image
    droplet_size       = var.droplet_size_2vcpu_2gb
    do_region          = var.do_region
    ssh_keys           = var.ssh_fingerprint
}

module "k8s_node" {
    source = "./modules/droplet"
    count  = 2

    droplet_name       = "node-${count.index + 1}"
    droplet_image      = data.digitalocean_image.centos.image
    droplet_size       = var.droplet_size_4vcpu_8gb
    do_region          = var.do_region
    ssh_keys           = var.ssh_fingerprint
}