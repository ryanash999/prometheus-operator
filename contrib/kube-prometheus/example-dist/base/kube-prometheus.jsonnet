local kubePrometheus = (import "kube-prometheus.libsonnet");

{[path]: std.manifestYamlDoc(kubePrometheus[path]) for path in std.objectFields(kubePrometheus)}
