#!/bin/bash

kustomize build common/dex/overlays/istio | kubectl apply -f -
