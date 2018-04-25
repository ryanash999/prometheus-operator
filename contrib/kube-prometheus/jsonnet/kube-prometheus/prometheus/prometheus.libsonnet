{
    _config+:: {
        namespace: "default",
        rules: {},
    }
} +
(import "prometheus-k8s-cluster-role-binding.libsonnet") +
(import "prometheus-k8s-cluster-role.libsonnet") +
(import "prometheus-k8s-role-binding-config.libsonnet") +
(import "prometheus-k8s-role-binding-namespace.libsonnet") +
(import "prometheus-k8s-role-binding-kube-system.libsonnet") +
(import "prometheus-k8s-role-binding-default.libsonnet") +
(import "prometheus-k8s-role-config.libsonnet") +
(import "prometheus-k8s-role-namespace.libsonnet") +
(import "prometheus-k8s-role-kube-system.libsonnet") +
(import "prometheus-k8s-role-default.libsonnet") +
(import "prometheus-k8s-rules.libsonnet") +
(import "prometheus-k8s-service-account.libsonnet") +
(import "prometheus-k8s-service-monitor-apiserver.libsonnet") +
(import "prometheus-k8s-service-monitor-coredns.libsonnet") +
(import "prometheus-k8s-service-monitor-kube-controller-manager.libsonnet") +
(import "prometheus-k8s-service-monitor-kube-scheduler.libsonnet") +
(import "prometheus-k8s-service-monitor-kubelet.libsonnet") +
(import "prometheus-k8s-service-monitor-prometheus.libsonnet") +
(import "prometheus-k8s-service.libsonnet") +
(import "prometheus-k8s.libsonnet")
