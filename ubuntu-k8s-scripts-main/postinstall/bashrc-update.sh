echo "export KUBECONFIG=\${HOME}/.kube/config" >> ${HOME}/.bashrc

echo "alias em='emacs'" >> ${HOME}/.bashrc

echo "alias ..='cd ..'" >> ${HOME}/.bashrc
echo "alias ...='cd ...'" >> ${HOME}/.bashrc
echo "alias ....='cd ....'" >> ${HOME}/.bashrc
echo "alias .....='cd .....'" >> ${HOME}/.bashrc

source ${HOME}/.bashrc
