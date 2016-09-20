resource "google_compute_http_health_check" "default" {
        name = "web-check"
        request_path = "/"
        check_interval_sec = 1
        healthy_threshold = 1
        unhealthy_threshold = 10
        timeout_sec = 1
}

resource "google_compute_target_pool" "default" {
        name = "web-target-pool"
        instances = ["${google_compute_instance.web.*.self_link}"]
        health_checks = ["${google_compute_http_health_check.default.name}"]
}

resource "google_compute_forwarding_rule" "default" {
        name = "web-forwarding-rule"
        target = "${google_compute_target_pool.default.self_link}"
        port_range = "80"
}

resource "google_compute_backend_service" "default" {
        name        = "backend"
        port_name   = "http"
        protocol    = "HTTP"
        timeout_sec = 10
        health_checks = ["${google_compute_http_health_check.default.self_link}"]
}
