#!/bin/bash

if [ "${environment_overlay}" == "ocp" ] ; then 
     $SCRIPT_DIR/tools/wait-for-rollout.sh deployment istio-ingressgateway-$ISTIO_TAG_REVISION istio-gateways 10 ${cluster_context}
     #./tools/wait-for-rollout.sh deployment istio-eastwestgateway-$ISTIO_TAG_REVISION istio-eastwest 10 ${cluster_context}
  else
     $SCRIPT_DIR/tools/wait-for-rollout.sh deployment istio-ingressgateway-$ISTIO_TAG_REVISION istio-gateways 10 ${cluster_context}
     #./tools/wait-for-rollout.sh deployment istio-eastwestgateway-$ISTIO_TAG_REVISION istio-eastwest 10 ${cluster_context}
  fi