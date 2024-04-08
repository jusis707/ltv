# ltv
# Sistēmu Administrators
## Izskaidrojums:
###### -   docker engine = atrodas minikube vidē
###### -   docker esošais uz host datora, atjauninātības ziņā ir = ar docker versiju minikube
##### minikube = docker + kubernetes klasteris darbināms uz vienas virtuālās mašīnas (nav fiziski jāveic vairāku instaču jeb host instalēšana ar master + slave konfigurāciju). minikube ir standalone versija kubernetes klasterim.
##### Manuāli veicamās darbības, opcionāli, komandas:
###### -   minikube ip
###### -   minikube ssh
###### -   minikube service laravel
##### Palaišanas skriptu install.sh nav ieteicams darbināt atkārtoti (rodas papildus darbības).
# veikt: sudo usermod -aG docker $USER && newgrp docker
