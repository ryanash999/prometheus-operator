local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local clusterRole = k.rbac.v1.clusterRole;
local policyRule = clusterRole.rulesType;

{
    clusterRole:
        local authenticationRole = policyRule.new() +
          policyRule.withApiGroups(["authentication.k8s.io"]) +
          policyRule.withResources([
            "tokenreviews",
          ]) +
          policyRule.withVerbs(["create"]);

        local authorizationRole = policyRule.new() +
          policyRule.withApiGroups(["authorization.k8s.io"]) +
          policyRule.withResources([
            "subjectaccessreviews",
          ]) +
          policyRule.withVerbs(["create"]);

        local rules = [authenticationRole, authorizationRole];

        clusterRole.new() +
          clusterRole.mixin.metadata.withName("node-exporter") +
          clusterRole.withRules(rules)
}
