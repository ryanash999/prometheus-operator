local k = import "ksonnet/ksonnet.beta.3/k.libsonnet";
local secret = k.core.v1.secret;

{
    secret:
        secret.new("alertmanager-main", {"alertmanager.yaml": std.base64($._config.alertmanagerConfig)}) +
          secret.mixin.metadata.withNamespace($._config.namespace)
}
