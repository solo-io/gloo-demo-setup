#!/bin/bash

until kubectl --context ${cluster_context} -n gloo-mesh wait --for condition=established crd/kubernetesclusters.admin.gloo.solo.io > /dev/null 2>&1; do sleep 10; done

kubectl apply --context ${cluster_context} -f- <<EOF
apiVersion: admin.gloo.solo.io/v2
kind: KubernetesCluster
metadata:
  name: mgmt
  namespace: gloo-mesh
spec:
  clusterDomain: cluster.local
EOF

# wait for gloo mesh mgmt server
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment gloo-mesh-mgmt-server gloo-mesh 10 ${cluster_context}

# wait for gloo mesh addons
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment ext-auth-service gloo-mesh-addons 10 ${cluster_context}
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment rate-limiter gloo-mesh-addons 10 ${cluster_context}
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment redis gloo-mesh-addons 10 ${cluster_context}

# Print the Gloo Platform UI URL
echo
echo "If using LoadBalancer External-IP:"
echo "access the Gloo UI at https://$(kubectl --context ${cluster_context} get svc -n istio-gateways --selector=istio=ingressgateway -o jsonpath='{.items[*].status.loadBalancer.ingress[0].*}')/gmui"
echo