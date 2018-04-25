#!/usr/bin/env bash
set -e
set -x

jsonnet="${1-kube-prometheus.jsonnet}"
prefix="${2-manifests}"
json="tmp/manifests.json"

rm -rf ${prefix}
mkdir -p $(dirname "${json}")
jsonnet -J jsonnet/kube-prometheus/vendor -J jsonnet/kube-prometheus ${jsonnet} > ${json}

files=$(jq -r 'keys[]' ${json})

for file in ${files}; do
    dir=$(dirname "${file}")
    path="${prefix}/${dir}"
    mkdir -p ${path}
    jq -r ".[\"${file}\"]" ${json} | gojsontoyaml -yamltojson | gojsontoyaml > "${prefix}/${file}"
done
