{
    _config+:: {
        namespace: "default",
    }
} +
(import "prometheus-operator-cluster-role-binding.libsonnet") +
(import "prometheus-operator-cluster-role.libsonnet") +
(import "prometheus-operator-deployment.libsonnet") +
(import "prometheus-operator-service-account.libsonnet") +
(import "prometheus-operator-service.libsonnet") +
(import "prometheus-operator-service-monitor.libsonnet")
