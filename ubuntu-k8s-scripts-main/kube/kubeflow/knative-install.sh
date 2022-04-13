#!/bin/bash

kustomize build common/knative/knative-serving/base | kubectl apply -f -
kustomize build common/istio-1-9/cluster-local-gateway/base | kubectl apply -f -

kustomize build common/knative/knative-eventing/base | kubectl apply -f -
