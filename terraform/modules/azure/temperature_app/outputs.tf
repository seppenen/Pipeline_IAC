output "ms_app_kubernetes_endpoint" {
  value = kubernetes_service.ms_service.status.0.load_balancer.0.ingress.0.ip
}