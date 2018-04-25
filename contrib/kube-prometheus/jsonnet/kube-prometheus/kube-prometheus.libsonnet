local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local kubernetes_mixin = (import "kubernetes-mixin/mixin.libsonnet") + {
    _config+:: {
        kube_state_metrics_selector: 'job="kube-state-metrics"',
        cadvisor_selector: 'job="kubelet"',
        node_exporter_selector: 'job="node-exporter"',
        kubelet_selector: 'job="kubelet',
        not_kube_dns_selector: 'job!="kube-dns"',
    }
};

local alertmanagerConfig = "
global:
  resolve_timeout: 5m
route:
  group_by: ['job']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 12h
  receiver: 'null'
  routes:
  - match:
      alertname: DeadMansSwitch
    receiver: 'null'
receivers:
- name: 'null'
";

local cfg = {
    _config+:: {
        namespace: "monitoring",
        rules: kubernetes_mixin.prometheus_rules + kubernetes_mixin.prometheus_alerts,
        dashboards: kubernetes_mixin.grafana_dashboards,
        alertmanagerConfig: alertmanagerConfig,
    },
};

local kube_prometheus = {
    alertmanager: (import "alertmanager/alertmanager.libsonnet") + cfg,
    ksm: (import "kube-state-metrics/kube-state-metrics.libsonnet") + cfg,
    nodeExporter: (import "node-exporter/node-exporter.libsonnet") + cfg,
    po: (import "prometheus-operator/prometheus-operator.libsonnet") + cfg,
    grafana: (import "grafana/grafana.libsonnet") + cfg,
    prometheus: (import "prometheus/prometheus.libsonnet") + cfg,
};

{
    "grafana/grafana-dashboard-definitions.yaml": kube_prometheus.grafana.dashboardDefinitions,
    "grafana/grafana-dashboard-sources.yaml":     kube_prometheus.grafana.dashboardSources,
    "grafana/grafana-datasources.yaml":           kube_prometheus.grafana.dashboardDatasources,
    "grafana/grafana-deployment.yaml":            kube_prometheus.grafana.deployment,
    "grafana/grafana-service-account.yaml":       kube_prometheus.grafana.serviceAccount,
    "grafana/grafana-service.yaml":               kube_prometheus.grafana.service,

    "alertmanager-main/alertmanager-main-secret.yaml":          kube_prometheus.alertmanager.secret,
    "alertmanager-main/alertmanager-main-service-account.yaml": kube_prometheus.alertmanager.serviceAccount,
    "alertmanager-main/alertmanager-main-service.yaml":         kube_prometheus.alertmanager.service,
    "alertmanager-main/alertmanager-main-service-monitor.yaml": kube_prometheus.alertmanager.serviceMonitor,
    "alertmanager-main/alertmanager-main.yaml":                 kube_prometheus.alertmanager.alertmanager,

    "kube-state-metrics/kube-state-metrics-cluster-role-binding.yaml": kube_prometheus.ksm.clusterRoleBinding,
    "kube-state-metrics/kube-state-metrics-cluster-role.yaml":         kube_prometheus.ksm.clusterRole,
    "kube-state-metrics/kube-state-metrics-deployment.yaml":           kube_prometheus.ksm.deployment,
    "kube-state-metrics/kube-state-metrics-role-binding.yaml":         kube_prometheus.ksm.roleBinding,
    "kube-state-metrics/kube-state-metrics-role.yaml":                 kube_prometheus.ksm.role,
    "kube-state-metrics/kube-state-metrics-service-account.yaml":      kube_prometheus.ksm.serviceAccount,
    "kube-state-metrics/kube-state-metrics-service.yaml":              kube_prometheus.ksm.service,
    "kube-state-metrics/kube-state-metrics-service-monitor.yaml":      kube_prometheus.ksm.serviceMonitor,

    "node-exporter/node-exporter-cluster-role-binding.yaml": kube_prometheus.nodeExporter.clusterRoleBinding,
    "node-exporter/node-exporter-cluster-role.yaml":         kube_prometheus.nodeExporter.clusterRole,
    "node-exporter/node-exporter-daemonset.yaml":            kube_prometheus.nodeExporter.daemonset,
    "node-exporter/node-exporter-service-account.yaml":      kube_prometheus.nodeExporter.serviceAccount,
    "node-exporter/node-exporter-service.yaml":              kube_prometheus.nodeExporter.service,
    "node-exporter/node-exporter-service-monitor.yaml":      kube_prometheus.nodeExporter.serviceMonitor,

    "prometheus-operator/prometheus-operator-cluster-role-binding.yaml": kube_prometheus.po.clusterRoleBinding,
    "prometheus-operator/prometheus-operator-cluster-role.yaml":         kube_prometheus.po.clusterRole,
    "prometheus-operator/prometheus-operator-deployment.yaml":           kube_prometheus.po.deployment,
    "prometheus-operator/prometheus-operator-service.yaml":              kube_prometheus.po.service,
    "prometheus-operator/prometheus-operator-service-monitor.yaml":      kube_prometheus.po.serviceMonitor,
    "prometheus-operator/prometheus-operator-service-account.yaml":      kube_prometheus.po.serviceAccount,

    "prometheus-k8s/prometheus-k8s-cluster-role-binding.yaml":                    kube_prometheus.prometheus.clusterRoleBinding,
    "prometheus-k8s/prometheus-k8s-cluster-role.yaml":                            kube_prometheus.prometheus.clusterRole,
    "prometheus-k8s/prometheus-k8s-service-account.yaml":                         kube_prometheus.prometheus.serviceAccount,
    "prometheus-k8s/prometheus-k8s-service.yaml":                                 kube_prometheus.prometheus.service,
    "prometheus-k8s/prometheus-k8s.yaml":                                         kube_prometheus.prometheus.prometheus,
    "prometheus-k8s/prometheus-k8s-rules.yaml":                                   kube_prometheus.prometheus.rules,
    "prometheus-k8s/prometheus-k8s-role-binding-config.yaml":                     kube_prometheus.prometheus.roleBindingConfig,
    "prometheus-k8s/prometheus-k8s-role-binding-namespace.yaml":                  kube_prometheus.prometheus.roleBindingNamespace,
    "prometheus-k8s/prometheus-k8s-role-binding-kube-system.yaml":                kube_prometheus.prometheus.roleBindingKubeSystem,
    "prometheus-k8s/prometheus-k8s-role-binding-default.yaml":                    kube_prometheus.prometheus.roleBindingDefault,
    "prometheus-k8s/prometheus-k8s-role-config.yaml":                             kube_prometheus.prometheus.roleConfig,
    "prometheus-k8s/prometheus-k8s-role-namespace.yaml":                          kube_prometheus.prometheus.roleNamespace,
    "prometheus-k8s/prometheus-k8s-role-kube-system.yaml":                        kube_prometheus.prometheus.roleKubeSystem,
    "prometheus-k8s/prometheus-k8s-role-default.yaml":                            kube_prometheus.prometheus.roleDefault,
    "prometheus-k8s/prometheus-k8s-service-monitor-apiserver.yaml":               kube_prometheus.prometheus.serviceMonitorApiserver,
    "prometheus-k8s/prometheus-k8s-service-monitor-coredns.yaml":                 kube_prometheus.prometheus.serviceMonitorCoreDNS,
    "prometheus-k8s/prometheus-k8s-service-monitor-kube-controller-manager.yaml": kube_prometheus.prometheus.serviceMonitorKubeControllerManager,
    "prometheus-k8s/prometheus-k8s-service-monitor-kube-scheduler.yaml":          kube_prometheus.prometheus.serviceMonitorKubeScheduler,
    "prometheus-k8s/prometheus-k8s-service-monitor-kubelet.yaml":                 kube_prometheus.prometheus.serviceMonitorKubelet,
    "prometheus-k8s/prometheus-k8s-service-monitor-prometheus.yaml":              kube_prometheus.prometheus.serviceMonitorPrometheus,
}
