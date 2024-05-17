#!/bin/bash

$SCRIPT_DIR/tools/wait-for-rollout.sh deployment istio-ingressgateway-$ISTIO_TAG_REVISION istio-gateways 10 ${cluster_context}
#$SCRIPT_DIR/tools/wait-for-rollout.sh deployment istio-eastwestgateway-$ISTIO_TAG_REVISION istio-eastwest 10 ${cluster_context}