# Terraform - output.tf

output "web public ip" {
	value = "${join(" ", google_compute_instance.web.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "database public ip" {
	value = "${google_compute_instance.db.network_interface.0.access_config.0.assigned_nat_ip}"
}

# EOF
