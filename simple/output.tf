# Terraform - output.tf

output "frontend ip" {
  value = "${google_compute_instance.frontend.network_interface.0.access_config.0.assigned_nat_ip}"
}

# EOF
