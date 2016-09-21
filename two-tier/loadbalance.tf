resource "google_compute_target_http_proxy" "default" {
	name        = "guestbook-proxy"
	url_map     = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_global_forwarding_rule" "default" {
	name       = "test"
	target     = "${google_compute_target_http_proxy.default.self_link}"
	port_range = "80"
}

resource "google_compute_url_map" "default" {
	name        	= "guestbook-url-map"
	default_service = "${google_compute_backend_service.web.self_link}"
}

resource "google_compute_instance_group" "webservers" {
	name        = "webservers"
	instances = ["${google_compute_instance.web.*.self_link}"]
	
	named_port {
		name = "http"
		port = "80"
	}
	zone = "${var.region_zone}"
}

resource "google_compute_backend_service" "web" {
	name        = "web-backend"
	port_name   = "http"
	protocol    = "HTTP"
	timeout_sec = 10
	enable_cdn  = false
	
	backend {
	      group = "${google_compute_instance_group.webservers.self_link}"
	}
	health_checks = ["${google_compute_http_health_check.web-check.self_link}"]
}

resource "google_compute_http_health_check" "web-check" {
	name = "web-check"
	request_path = "/"
	check_interval_sec = 1
	healthy_threshold = 1
	unhealthy_threshold = 10
	timeout_sec = 1
}

