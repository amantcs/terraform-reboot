
output "subnet01_id" {
  value = azurerm_subnet.subnet01.id
}

output "vm_ip" {
  value = azurerm_public_ip.pub_ip01.ip_address
}