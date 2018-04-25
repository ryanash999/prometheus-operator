local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local configMap = k.core.v1.configMap;

{
    rules:
        configMap.new("prometheus-k8s-rules", {"all.rules.yaml": std.manifestYamlDoc($._config.rules)}) +
          configMap.mixin.metadata.withLabels({role: "alert-rules", prometheus: "k8s"}) +
          configMap.mixin.metadata.withNamespace($._config.namespace)
}
