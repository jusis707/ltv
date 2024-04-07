#/bin/bash
read -p "Are you sure? type y or no.
----------------------------------------
               UZMANIBU
----------------------------------------

" -n 1 -r
echo ""
echo "========================================"
echo  "UZMANIBU"  # (optional) move to a new line
echo "========================================"
if [[ $REPLY =~ ^[Yy]$ ]]
then
mkdir ~/ltv
cd ~/ltv
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl mc rsync -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo groupadd docker
minikube version
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install kubectl -y
sudo apt-get install bash-completion -y
source /usr/share/bash-completion/bash_completion
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#sudo echo "{ "insecure-registries" : [ "10.0.0.0/16" ] }" > /etc/docker/daemon.json
#sed 's/\[Service\]/\[Service\] \nEnvironment=DOCKER_OPTS=--insecure-registry=10.0.0.0/16/' /lib/systemd/system/docker.service > /lib/systemd/system/docker.service.tmp
#mv /lib/systemd/system/docker.service.tmp /lib/systemd/system/docker.service
echo "horizonts" > ~/p.txt
cat ~/p.txt | docker login --username jurismuris --password-stdin quay.io
minikube config set cpus 4
minikube config set memory 4084
sudo usermod -aG docker $USER
#&& newgrp docker
newgrp docker << FOO
FOO
#sudo usermod -aG docker $USER
#sudo newgrp docker
#sudo usermod -aG docker $USER && newgrp docker
minikube start --insecure-registry "10.0.0.0/24" --driver=docker
minikube addons enable metrics-server
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
minikube addons enable ingress
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
echo "pacietiba..."
minikube addons enable registry
wget https://github.com/jusis707/ltv/raw/main/s.yaml
wget https://github.com/jusis707/ltv/raw/main/p.yaml
wget https://github.com/jusis707/ltv/raw/main/hpa.yaml
wget https://github.com/jusis707/ltv/raw/main/cm.yaml
wget https://github.com/jusis707/ltv/raw/main/c.yaml
wget https://github.com/jusis707/ltv/raw/main/sec.yaml
kubectl apply -f p.yaml
kubectl apply -f cm.yaml
kubectl apply -f s.yaml
kubectl apply -f sec.yaml
kubectl apply -f c.yaml
kubectl apply -f hpa.yaml
clear
minikube ip >ip-kube &
#pods_count=$(kubectl get pods | grep -c "Running")
#while [[ $pods_count -ne $(kubectl get pods | grep -c "") ]]
#do
#  echo "waiting for all pods to be ready"
#  sleep 10
#done
#echo "All pods are ready"
sleep 2
kubectl  get services
echo "----------------------------------------"
echo  "UZMANIBU gaida uz podu gataviibu"  # (optional) move to a new line
echo "----------------------------------------"
kubectl wait pod --all --for=condition=Ready --timeout=5m
sleep 1
echo "----------------------------------------"
echo  "UZMANIBU ekraans buus notiiriits.. gaidiit..."  # (optional) move to a new line
echo "----------------------------------------"
sleep 3
clear
minikube service laravel
echo "gaidiit.."
sleep 5
echo "turpinaat nospiest y"
read -p "Are you sure? type y or no." -n 1 -r
echo ""
echo "----------------------------------------"
echo  "UZMANIBU"  # (optional) move to a new line
echo "----------------------------------------"
if [[ $REPLY =~ ^[Yy]$ ]]
then
lsb_release -a | grep Desc | awk '{print $2,$3}'>o1
docker --version | awk '{print $1, $2, $3}' | sed 's/,//' >>o1
cat o1 | awk '{print}' ORS='/' >o2
cat o2 | sed 's/ /_/g'>o3
echo ""
curl -sS -X POST 'https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f' -H 'content-type: application/json' -d $(cat o3) -o /dev/null
echo ""
# Explain what information will be sent
echo "This script will send your Ubuntu version and (optionally sanitized) Docker version to a webhook."

# Get user confirmation
if ! confirm_action; then
  exit 0
fi

# Capture system information
ubuntu_version=$(lsb_release -a | grep Desc | awk '{print $2}')
docker_version=$(docker --version | awk '{print $1, $2}')

# Optional: Sanitize Docker version (remove patch version)
# docker_version=${docker_version%%.*}  # Example - removes patch version

# Secure webhook URL (replace with interviewer's instructions)
webhook_url="https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f"

# Prepare data payload (consider JSON format for flexibility)
payload="{\"ubuntu_version\": \"$ubuntu_version\", \"docker_version\": \"$docker_version\"}"

# Send data using curl (replace with interviewer's preferred method)
if [[ $webhook_url ]]; then
  echo "Sending data to webhook..."
  curl -sS -X POST "$webhook_url" -H 'Content-Type: application/json' -d "$payload" > /dev/null
fi

echo "Done."
echo ""
echo "MYSQL turpinaat nospiest y"
read -p "Are you sure? type y or no." -n 1 -r
echo ""
echo "----------------------------------------"
echo  "UZMANIBU"  # (optional) move to a new line
echo "----------------------------------------"
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "
kubectl run -it --rm --image=mysql:8.0 --restart=Never mysql-client -- mysql -h laravel -pASdf456+
SHOW DATABASES;
QUIT;
"
fi
fi
fi
