export VERSION=5:19.03.11~3-0~ubuntu-focal

sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable"
sudo apt update
sudo apt-get remove docker docker-engine docker.io
#sudo apt-get install docker-ce=${VERSION} docker-ce-cli=${VERSION} containerd.io
sudo apt install docker.io
docker --version
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker ${USER}
