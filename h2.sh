#/bin/bash
read -p "
========================================
               UZMANĪBU
========================================
           y lai turpinātu
          CTRL + C lai izietu
========================================
" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
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
minikube ssh 'sudo apt-get install wget -y;wget https://github.com/jusis707/ltv/raw/main/mini.sh -v -O install.sh; chmod +x ./install.sh; bash ./install.sh'
clear
sleep 1
echo "========================================"
echo  "UZMANĪBU"  # (optional) move to a new line
echo "Docker versija minikube vidē:"
minikube ssh 'docker --version'
echo "========================================"
sleep 2
wget https://github.com/jusis707/ltv/raw/main/s.yaml -q
wget https://github.com/jusis707/ltv/raw/main/p.yaml -q
wget https://github.com/jusis707/ltv/raw/main/hpa.yaml -q
wget https://github.com/jusis707/ltv/raw/main/cm.yaml -q
wget https://github.com/jusis707/ltv/raw/main/c.yaml -q
wget https://github.com/jusis707/ltv/raw/main/sec.yaml -q
kubectl apply -f p.yaml
kubectl apply -f cm.yaml
kubectl apply -f s.yaml
kubectl apply -f sec.yaml
kubectl apply -f c.yaml
kubectl apply -f hpa.yaml
clear
minikube ip >ip-kube &
sleep 2
echo "----------------------------------------"
echo  "Gaidam uz konteineru gatavību"  # (optional) move to a new line
echo "----------------------------------------"
echo ""
kubectl wait pod --all --for=condition=Ready --timeout=5m 2>/dev/null &
pid=$!  # Capture the process ID of the previous command
spin=( "-" "\\" "|" "/" )  # Create an array for spinner characters
echo -n "[gaidīt] ${spin[0]}"  # Print the initial spinner character
while kill -0 $pid 2>/dev/null; do  # Check if the process is running
    for i in "${spin[@]}"; do  # Iterate through spinner characters
        echo -ne "\b$i"  # Overwrite previous character with a new one
        sleep 0.2        # Delay for animation effect
    done
done
echo
##kubectl wait pod --all --for=condition=Ready --timeout=5m
##sleep 1
echo "----------------------------------------"
echo  "Uzskatāmībai, ekrāns būs notīrīts"  # (optional) move to a new line
echo "----------------------------------------"
sleep 3
clear
minikube service laravel
echo "augstāk redzamo piefiksēt"
sleep 5
echo ""
read -p "lai turpinātu, nospiest y" -n 1 -r
echo ""
echo "----------------------------------------"
echo  "tiek sagatavots webhook query"  # (optional) move to a new line
echo  "docker versija uz host servera un minikube vidē ir = un atjaunināta" 
echo "----------------------------------------"
sleep 3
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
echo "Ubuntu" >o1
cat /etc/lsb-release | sed -n 4p | awk '{print $2}' >>o1
minikube ssh 'docker --version' | awk '{print $1, $2, $3}' | sed 's/,//' >>o1
cat o1 | awk '{print}' ORS='/' >o2
cat o2 | sed 's/ /_/g'>o3
echo "Pārlūkprogramā atvērt:
https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1
"
curl -sS -X POST 'https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f' -H 'content-type: application/json' -d $(cat o3) -o /dev/null
echo ""
echo "augstāk redzamo piefiksēt, un pārliecināties par query datu pareizību atverot saiti"
echo ""
echo ""
read -p "lai turpinātu un pārietu uz MYSQL pārbaudi nospiest y" -n 1 -r
echo ""
echo "----------------------------------------"
echo  "piefiksēt norādīto zemāk, veicot manuāli:"  # (optional) move to a new line
echo "----------------------------------------"
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
echo "
Pārbaudīt mysql datubāzes pieejamību.
kubectl run -it --rm --image=mysql:8.0 --restart=Never mysql-client -- mysql -h laravel -pASdf456+
SHOW DATABASES;
QUIT;
"
fi
fi
fi
