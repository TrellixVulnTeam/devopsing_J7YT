#!/bin/bash

export KF_MAN_DIR=${REPO}/manifests
KFSCRIPTS=${SCRIPTS}/kube/kubeflow
KF_MANIFESTS=https://github.com/kubeflow/manifests.git

if [ ! -d ${KF_MAN_DIR} ]
then
    (cd ${REPO}; \
     git clone ${KF_MANIFESTS})
fi

(cd ${KF_MAN_DIR}; \
 ${KFSCRIPTS}/cert-manager.sh && \
 ${KFSCRIPTS}/istio-install.sh && \
 ${KFSCRIPTS}/dex-install.sh && \
 ${KFSCRIPTS}/oidc-auth.sh && \
 ${KFSCRIPTS}/knative-install.sh && \
 ${KFSCRIPTS}/kubeflow-init.sh
)
