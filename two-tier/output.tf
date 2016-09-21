# Terraform - output.tf

output "frontend ip" {
	value = "${google_compute_global_forwarding_rule.default.ip_address}" 
}

#output "backends" {
#	value = "${join(" ", google_compute_instance.web.*.network_interface.0.access_config.0.assigned_nat_ip)}"
#}
#
#output "database" {
#	value = "${google_compute_instance.db.network_interface.0.access_config.0.assigned_nat_ip}"
#}

# EOF
