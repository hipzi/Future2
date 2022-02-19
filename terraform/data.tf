# get the data about an official image centos
data "digitalocean_image" "centos" {
  slug = "centos-7-x64"
}