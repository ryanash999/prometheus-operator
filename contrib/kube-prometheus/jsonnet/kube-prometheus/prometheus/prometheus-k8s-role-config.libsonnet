local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local role = k.rbac.v1.role;
local policyRule = role.rulesType;

{
    roleConfig:
        local configmapRule = policyRule.new() +
          policyRule.withApiGroups([""]) +
          policyRule.withResources([
            "configmaps",
          ]) +
          policyRule.withVerbs(["get"]);

        role.new() +
          role.mixin.metadata.withName("prometheus-k8s-config") +
          role.mixin.metadata.withNamespace($._config.namespace) +
          role.withRules(configmapRule),
}
