#!/bin/bash

$SCRIPT_DIR/tools/wait-for-rollout.sh deployment istio-operator-$ISTIO_TAG_REVISION gm-iop-$ISTIO_TAG_REVISION 10 ${cluster_context}
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment istiod-$ISTIO_TAG_REVISION istio-system 10 ${cluster_context}
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment istio-ingressgateway-$ISTIO_TAG_REVISION istio-gateways 10 ${cluster_context}
#./tools/wait-for-rollout.sh deployment istio-eastwestgateway-$ISTIO_TAG_REVISION istio-eastwest 10 ${cluster_context}