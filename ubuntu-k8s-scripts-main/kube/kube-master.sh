#!/bin/bash

rm -rf ${HOME}/.kube/
sudo swapoff -a

sudo kubeadm reset
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --service-cidr=10.18.0.0/24

#--pod-network-cidr=10.244.0.0/16

mkdir -p ${HOME}/.kube
sudo cp -i /etc/kubernetes/admin.conf ${KUBECONFIG}
sudo chown $(id -u):$(id -g) ${KUBECONFIG}

#echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
#sudo sysctl -p

#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/master-

#sudo cp ${SCRIPTS}/kube/yml/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
./lp-provisioner.sh
