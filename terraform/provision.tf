resource "local_file" "ansible_inventory" {
  filename = "${var.ansible_path}/hosts"
  content  = <<-EOT
    [master]
    ${module.k8s_master.droplet_ipv4_address}

    [master_ha]
    %{ for ip in module.k8s_master_ha[*].droplet_ipv4_address ~}
    ${~ ip}
    %{ endfor ~}

    [worker]
    %{ for ip in module.k8s_node[*].droplet_ipv4_address ~}
    ${~ ip}
    %{ endfor ~}

    [haproxy]
    ${module.haproxy.droplet_ipv4_address}

    [kubernetes_master:children]
    master
    master_ha

    [kubernetes_cluster:children]
    master
    master_ha
    worker

    [server:children]
    master
    master_ha
    worker
    haproxy
  EOT
}

resource "local_file" "host_script" {
  filename = "./add_host.sh"

  content = <<-EOT
  echo "Adding IPs"

  ssh-keyscan -T 240 -H ${module.k8s_master.droplet_ipv4_address} >> ~/.ssh/known_hosts
  %{ for ip in module.k8s_master_ha[*].droplet_ipv4_address ~}
  ssh-keyscan -T 240 -H ${ip} >> ~/.ssh/known_hosts 
  %{ endfor ~}
  %{ for ip in module.k8s_node[*].droplet_ipv4_address ~}
  ssh-keyscan -T 240 -H ${ip} >> ~/.ssh/known_hosts 
  %{ endfor ~}
  ssh-keyscan -T 240 -H ${module.haproxy.droplet_ipv4_address} >> ~/.ssh/known_hosts
  sleep 20

  EOT

  provisioner "local-exec" {
    command = "bash add_host.sh"
  }
}

resource "local_file" "ansible_config" {
  filename = "${var.ansible_path}/ansible.cfg"
  content  = <<-EOT
    [defaults]
    host_key_checking = ${var.ansible_host_key_checking}
    inventory = ${local_file.ansible_inventory.filename}
    roles_path =  ${var.ansible_host_key_checking}
  EOT
}

resource "null_resource" "ansible" {
  triggers = {
    order = local_file.host_script.id
  }
  provisioner "local-exec" {
    working_dir = var.ansible_path
    command = "ansible-playbook -u root --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' automation.yaml"
  }
}
