{
    _config+:: {
        namespace: "default"
    }
} +
(import "alertmanager-main-secret.libsonnet") +
(import "alertmanager-main-service-account.libsonnet") +
(import "alertmanager-main-service.libsonnet") +
(import "alertmanager-main-service-monitor.libsonnet") +
(import "alertmanager-main.libsonnet")
