local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

{
    service:
        local nodeExporterPort = servicePort.newNamed("https", 9100, "https");

        service.new("node-exporter", $.daemonset.spec.selector.matchLabels, nodeExporterPort) +
          service.mixin.metadata.withNamespace($._config.namespace) +
          service.mixin.metadata.withLabels({"k8s-app": "node-exporter"})
}
