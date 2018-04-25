local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

{
    service:
        local prometheusPort = servicePort.newNamed("web", 9090, "web");

        service.new("prometheus-k8s", {app: "prometheus", prometheus: "k8s"}, prometheusPort) +
          service.mixin.metadata.withNamespace($._config.namespace) +
          service.mixin.metadata.withLabels({prometheus: "k8s"})
}
