local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local clusterRoleBinding = k.rbac.v1.clusterRoleBinding;

{
    clusterRoleBinding:
        clusterRoleBinding.new() +
          clusterRoleBinding.mixin.metadata.withName("prometheus-operator") +
          clusterRoleBinding.mixin.roleRef.withApiGroup("rbac.authorization.k8s.io") +
          clusterRoleBinding.mixin.roleRef.withName("prometheus-operator") +
          clusterRoleBinding.mixin.roleRef.mixinInstance({kind: "ClusterRole"}) +
          clusterRoleBinding.withSubjects([{kind: "ServiceAccount", name: "prometheus-operator", namespace: $._config.namespace}])
}
