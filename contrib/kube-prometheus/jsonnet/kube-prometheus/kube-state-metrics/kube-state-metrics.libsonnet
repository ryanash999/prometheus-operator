{
    _config+:: {
        namespace: "default",
    }
} +
(import "kube-state-metrics-cluster-role-binding.libsonnet") +
(import "kube-state-metrics-cluster-role.libsonnet") +
(import "kube-state-metrics-deployment.libsonnet") +
(import "kube-state-metrics-role-binding.libsonnet") +
(import "kube-state-metrics-role.libsonnet") +
(import "kube-state-metrics-service-account.libsonnet") +
(import "kube-state-metrics-service.libsonnet") +
(import "kube-state-metrics-service-monitor.libsonnet")
