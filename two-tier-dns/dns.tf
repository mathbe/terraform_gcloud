# Terraform - dns.tf

resource "google_dns_managed_zone" "test" {
	name        = "test-zone"
	dns_name    = "${var.subdomain}"
}

resource "google_dns_record_set" "record" {
	name = "${var.record}.${google_dns_managed_zone.test.dns_name}"
	type = "A"
	ttl  = 60

	managed_zone = "${google_dns_managed_zone.test.name}"

	rrdatas = ["${google_compute_global_forwarding_rule.default.ip_address}"]
}

# EOF
