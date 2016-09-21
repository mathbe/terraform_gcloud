# Terraform - output.tf

output "frontend ip" {
	value = "${google_compute_global_forwarding_rule.default.ip_address}" 
}

output "in order to enable your sub domain, configure your domain with the following NS records: " {
	value = ["${google_dns_managed_zone.test.name_servers}"]
}

# EOF
