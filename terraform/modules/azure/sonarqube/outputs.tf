output "sonarqube_kubernetes_endpoint" {
  value = kubernetes_service.sq_service.status.0.load_balancer.0.ingress.0.ip
}
