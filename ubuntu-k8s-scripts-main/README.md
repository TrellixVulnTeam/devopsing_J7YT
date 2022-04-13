# ubuntu-k8s-scripts

*run-postinstall.sh*

One-click setup all necessary software and adds some useful aliases to ~/.bashrc file
Applies one optional NEED_VM argument if virtual machine (kvm) installation is also required.
The next software will be installed at this step:

- git (gitk)
- openssh-server
- emacs
- net-tools
- helm
- yq
- python3-pip
- docker
- kvm (optionally)
- kubeadm/kubelet/kubectl


*create-vm.sh*

Instantiates the new virtual machine. 
The NAME argument is required (to specify VM name)
By default it loads the ubuntu-20.04.3 image to `iso` folder (if it doesn't exist)
