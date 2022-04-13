#!/bin/bash

kustomize build common/cert-manager/cert-manager/base | kubectl apply -f -
sleep 5
kustomize build common/cert-manager/kubeflow-issuer/base | kubectl apply -f -

exit $?
