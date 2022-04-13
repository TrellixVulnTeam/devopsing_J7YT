#!/bin/bash

# Disable fw
sudo systemctl stop ufw
sudo systemctl disable ufw

kubectl apply -f ${SCRIPTS}/kube/yml/local-path-storage.yaml
kubectl create -f ${SCRIPTS}/kube/yml/pvc.yaml
# kubectl create -f ${SCRIPTS}/kube/yml/pod.yaml

kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
