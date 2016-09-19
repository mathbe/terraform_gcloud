# Terraform - output.tf

output "guestbook ip" {
  value = "${google_compute_instance.guestbook.network_interface.0.access_config.0.assigned_nat_ip}"
}

# EOF
