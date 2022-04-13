#!/bin/bash

kustomize build common/oidc-authservice/base | kubectl apply -f -
