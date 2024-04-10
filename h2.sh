#/bin/bash
read -p "
===========================================================================================
                                        UZMANĪBU
                                      bija jāveic:
                                 sudo groupadd docker
                      sudo usermod -aG docker $USER && newgrp docker
===========================================================================================
                                   y lai turpinātu
                                 CTRL + C lai izietu
                                   risinājums Nr.1
                                  
                           Uzstādīšana notiks interaktīvi...
                        Lūgums sekot norādījumiem uz ekrāna
  Iespējamie izvēles varianti ir apstiprinoši (tikai), jo zūd jēga, ar cita veida darbībām
===========================================================================================
                                   y lai turpinātu
                                 CTRL + C lai izietu
===========================================================================================
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
mkdir ~/ltv
cd ~/ltv
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl mc rsync docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
clear
echo "---------------------------------------------------------"
minikube version
sleep 1
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
echo 'aG9yaXpvbnRzCg==' | base64 --decode > ~/ltv/p.txt
cat ~/ltv/p.txt | docker login --username jusis707 --password-stdin docker.io
clear
minikube config set cpus 4
minikube config set memory 4096
sudo usermod -aG docker $USER
minikube start --insecure-registry "10.0.0.0/24" --driver=docker
echo ""
clear
echo "---------------------------------------------------------"
echo "uzgaidīt..."
minikube addons enable metrics-server
echo ""
clear
echo "---------------------------------------------------------"
echo "uzgaidīt..."
minikube addons enable ingress
echo ""
clear
echo "---------------------------------------------------------"
echo "uzgaidīt..."
minikube addons enable registry
echo ""
clear
echo "---------------------------------------------------------"
echo "tiks veikta minikube vides atjaunināšana..."
minikube ssh 'curl -sSLv https://raw.githubusercontent.com/jusis707/ltv-uzdevums/main/mini.sh -o install.sh; chmod +x ./install.sh; bash ./install.sh'
echo ""
minikube stop
sleep 2
echo ""
minikube start --insecure-registry "10.0.0.0/24" --driver=docker
echo ""
echo "====================================================="
echo  "UZMANĪBU"  # (optional) move to a new line
echo "Docker versija minikube vidē:"
minikube ssh 'docker --version'
echo "====================================================="
sleep 2
clear
echo "---------------------------------------------------------"
echo "startējam yaml manifestus..."
echo ""
wget https://github.com/jusis707/ltv/raw/main/s.yaml -O ~/ltv/s.yaml -q
wget https://github.com/jusis707/ltv/raw/main/p.yaml -O ~/ltv/p.yaml -q
wget https://github.com/jusis707/ltv/raw/main/hpa.yaml -O ~/ltv/hpa.yaml -q
wget https://github.com/jusis707/ltv/raw/main/cm.yaml -O ~/ltv/cm.yaml -q
wget https://github.com/jusis707/ltv/raw/main/c.yaml -O ~/ltv/s.yaml -q
wget https://github.com/jusis707/ltv/raw/main/sec.yaml -O ~/ltv/sec.yaml -q
wget https://github.com/jusis707/ltv/raw/main/in.yaml -O ~/ltv/in.yaml -q
wget https://github.com/jusis707/ltv/raw/main/welcome.blade.php -O ~/ltv/welcome.blade.php -q
kubectl apply -f ~/ltv/sec.yaml
kubectl apply -f ~/ltv/c.yaml
kubectl apply -f ~/ltv/p.yaml
kubectl apply -f ~/ltv/cm.yaml
kubectl apply -f ~/ltv/s.yaml
kubectl apply -f ~/ltv/hpa.yaml
clear
minikube ip >ip-kube &
echo "---------------------------------------------------------"
echo "var tikt jautāta lietotāja parole (laravel.ltv.lv pievienošana /etc/hosts)..."
echo ""
sudo -- sh -c "echo $(minikube ip) laravel.ltv.lv >> /etc/hosts"
sleep 1
clear
echo "---------------------------------------------------------"
echo  "Gaidam uz konteineru gatavību"
echo ""
kubectl wait pod --all --for=condition=Ready --timeout=5m 2>/dev/null &
pid=$!
spin=( "-" "\\" "|" "/" )
echo -n "[... gaidīt] ${spin[0]}"
while kill -0 $pid 2>/dev/null; do
    for i in "${spin[@]}"; do
        echo -ne "\b$i"
        sleep 0.2
    done
done
echo
echo -e "\n"
clear
echo "---------------------------------------------------------"
echo  "startējam ingress manifestu..."
kubectl apply -f in.yaml
sleep 1
clear
echo "---------------------------------------------------------"
echo  "Uzskatāmībai, ekrāns būs notīrīts"
echo ""
sleep 1
clear
echo ""
echo ""
minikube service laravel
echo "---------------------------------------------------------"
echo "pēc izvēles, augstāk redzamo piefiksēt"
sleep 3
echo ""
read -p "
----------------------------------------------------------------------
                  lai turpinātu, nospiest y
               tiks sagatavots webhook query
docker versija uz host servera un minikube vidē ir = un atjaunināta
webhook saite:
https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1
----------------------------------------------------------------------
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
os_name="Ubuntu"
os_version=$(cat /etc/lsb-release | sed -n 4p | awk '{print $2}')
docker_version=$(minikube ssh docker version | awk '{print $1, $2, $3}' | tr ',' ' ')
# Combine information into a single file (o1)
printf "%s\n%s\n%s" "$os_name" "$os_version" "$docker_version" >o1
# Format and clean output (o2, o3)
tr '/' '_' < o1 > o2
sed -i 's/ /_/g' o2 
echo "System Information:"
cat o2 | xargs -I {} echo "{}"
echo
#open "https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1"
curl -s -X POST -H 'Content-Type: application/json' -d @o2 'https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f'
echo ""
echo "---------------------------------------------------------"
echo "augstāk redzamo piefiksēt, un pārliecināties par query datu pareizību atverot saiti"
echo ""
kubectl get pods -o name --no-headers=true | sed 's/pod\///g'> ./run.pod
kubectl cp welcome.blade.php `cat run.pod`:/var/www/html/vdc/resources/views/welcome.blade.php
clear
echo "-----------------------------------------------------------------------"
read -p "lai turpinātu un pārietu uz MYSQL pārbaudi nospiest y
            piefiksēt norādīto zemāk, veicot manuāli:
                            nospiest y
-----------------------------------------------------------------------------
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
wget https://github.com/jusis707/ltv/raw/main/inst.txt -q
clear
echo -e $(cat ~/ltv/inst.txt)
fi
fi
fi
