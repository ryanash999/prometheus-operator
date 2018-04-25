local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;

{
    service:
        local ksmServicePortMain = servicePort.newNamed("https-main", 8443, "https-main");
        local ksmServicePortSelf = servicePort.newNamed("https-self", 9443, "https-self");

        service.new("kube-state-metrics", $.deployment.spec.selector.matchLabels, [ksmServicePortMain, ksmServicePortSelf]) +
          service.mixin.metadata.withNamespace($._config.namespace) +
          service.mixin.metadata.withLabels({"k8s-app": "kube-state-metrics"})
}
