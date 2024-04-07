!/bin/bash
mkdir ~/ltv
cd ~/ltv
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl mc rsync
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo usermod -aG docker $USER && newgrp docker
minikube version
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
sudo apt-get install bash-completion
source /usr/share/bash-completion/bash_completion
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo cat << EOF > /etc/docker/daemon.json { "insecure-registries" : [ "10.0.0.0/16" ] } EOF
docker login -u 'jurismuris' -p 'horizonts' -e 'embergs.usa@gmail.com' quay.io
minikube config set cpus 4
minikube config set memory 5384
minikube start --insecure-registry "10.0.0.0/24" --driver=docker
minikube addons enable metrics-server
minikube addons enable ingress
minikube addons enable registry
kubectl apply -f p.yaml
kubectl apply -f cm.yaml
kubectl apply -f s.yaml
kubectl apply -f sec.yaml
kubectl apply -f c.yaml
kubectl apply -f hpa.yaml
minikube ip >ip-kube &
