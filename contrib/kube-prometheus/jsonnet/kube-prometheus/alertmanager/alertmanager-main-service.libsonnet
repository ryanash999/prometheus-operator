local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

{
    service:
        local alertmanagerPort = servicePort.newNamed("web", 9093, "web");

        service.new("alertmanager-main", {app: "alertmanager", alertmanager: "main"}, alertmanagerPort) +
          service.mixin.metadata.withNamespace($._config.namespace) +
          service.mixin.metadata.withLabels({alertmanager: "main"})
}
