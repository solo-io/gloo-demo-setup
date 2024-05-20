#!/bin/bash

# wait for completion of bookinfo install
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment productpage-v1 bookinfo-frontends 10 ${cluster_context}

LOADBALANCER_IP=$(kubectl --context ${cluster_context} get svc -n istio-gateways --selector=istio=ingressgateway -o jsonpath='{.items[*].status.loadBalancer.ingress[0].*}')
NAMESPACE=bookinfo-frontends
URL=https://${LOADBALANCER_IP}/productpage

kubectl apply --context=$cluster_context -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: ${NAMESPACE}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: generate-traffic
  namespace: ${NAMESPACE}
  labels:
    app: gloo-mesh-traffic
spec:
  selector:
    matchLabels:
      app: gloo-mesh-traffic
  template:
    metadata:
      labels:
        app: gloo-mesh-traffic
    spec:
      containers:
        # Generate traffic on URL
        - name: generate-traffic
          image: curlimages/curl
          command:
            - /bin/sh
            - -c
            - |
              while :
              do
                curl -k -I ${URL}
                sleep 30
              done
          resources:
            requests:
              cpu: 20m
              memory: 25Mi
EOF