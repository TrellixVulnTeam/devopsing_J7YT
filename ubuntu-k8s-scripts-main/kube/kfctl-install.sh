OPERATOR_NAMESPACE=operators
KUBEFLOW_NAMESPACE=kubeflow
KFDEF_URL=https:///raw.githubusercontent.com/kubeflow/manifests/14de0c7dc27231c0a5840f99f125acc73a351ce1/kfdef/kfctl_ibm_dex.yaml &&
KUBEFLOW_DEPLOYMENT_NAME=kubeflow

    
if [ ! -d ${REPO}/kfctl ]
then
    (cd ${REPO} && \
     git clone https://github.com/kubeflow/kfctl.git)
fi

kubectl create ns ${OPERATOR_NAMESPACE}
kubectl create ns ${KUBEFLOW_NAMESPACE}

(cd ${REPO}/kfctl/deploy && \
 kustomize edit set namespace ${OPERATOR_NAMESPACE} && \
 kustomize build | kubectl apply -f - && \
 export KFDEF=$(echo "${KFDEF_URL}" | rev | cut -d/ -f1 | rev) && \
 curl -L ${KFDEF_URL} > ${KFDEF} && \
 yq eval '.metadata.name = "'${KUBEFLOW_DEPLOYMENT_NAME}'"' ${KFDEF} > ${KFDEF}.tmp && mv ${KFDEF}.tmp ${KFDEF} && \
 kubectl create -f ${KFDEF} -n ${KUBEFLOW_NAMESPACE}
 )
