# Terraform 0.12 compatible

variable "hostname" {}
variable "plan" {}
variable "operating_system" {}
variable "locations" {}

variable "auth_token" {}
variable "org_id" {}
variable "project_id" {}
variable "ssh_public_key" {}

# Configure the Packet Provider. 
provider "packet" {
  auth_token = var.auth_token
}

resource "packet_project_ssh_key" "rougue01" {
  name       = "rougue01"
  public_key = file(var.ssh_public_key)
  project_id = var.project_id
}

# Instantiate a bare metal server
resource "packet_device" "rougue01" {
  hostname         = var.hostname
  plan             = var.plan
  facilities       = var.locations
  operating_system = var.operating_system
  billing_cycle    = "hourly"
  project_id       = var.project_id
  project_ssh_key_ids = [packet_project_ssh_key.rougue01.id]  
}

output "ipv4" {
  value = packet_device.rougue01.access_public_ipv4
}
#output "root_password" {
#  value = packet_device.rougue01.root_password
#}

