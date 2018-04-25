{
    _config+:: {
        namespace: "default",
    }
} +
(import "node-exporter-cluster-role-binding.libsonnet") +
(import "node-exporter-cluster-role.libsonnet") +
(import "node-exporter-daemonset.libsonnet") +
(import "node-exporter-service-account.libsonnet") +
(import "node-exporter-service.libsonnet") +
(import "node-exporter-service-monitor.libsonnet")
