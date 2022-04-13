*bashrc-update.sh*

Here you may add writing to ~/.bashrc some useful aliases and env variables
that could be used at all of your node machines

*other.sh*

Script for installation all additional useful software (see list at ../README.md)

*docker-install.sh*

Install (re-install) latest docker.io, add user to *docker* group, etc.

If you need to install some specific docker version, define the version at the line
`export VERSION=5:19.03.11~3-0~ubuntu-focal`
then uncomment this line
`sudo apt-get install docker-ce=${VERSION} docker-ce-cli=${VERSION} containerd.io`
and comment this
`#sudo apt install docker.io`

*kvm-install.sh*

Install KVM, virt-manager and all related libraries

*k8s-install.sh*

Install `kubelet`, `kubeadm` and `kubectl` utilities.
Buy default the installed version is 1.20.12-00
For install another version, set it to `K8S_VERSION` environment variable.