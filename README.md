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
##### (lai neveiktu sudo chmod 666 /var/run/docker.sock )
###### Datne ar nosaukumu "welcome.blade.php" tika pārveidota, lai apliecinātu Laravel pieslēgumu datubāzei.
izmaiņas, ar ./resources/views/welcome.blade.php
<div class="links">
   <strong>Database Connected: </strong>
    @php
        try {
            DB::connection()->getPDO();
            echo DB::connection()->getDatabaseName();
            } catch (\Exception $e) {
            echo 'None';
        }
    @endphp
</div>"

## - Pārbaudīt mysql datubāzes pieejamību, katru komandrindu startējot atsevišķi (nospiest ENTER pēc pieprasījuma). \n
## kubectl run -it --rm --image=mysql:latest --restart=Never mysql-client -- mysql -h laravel -pASdf456+ \n
## SHOW DATABASES; \n
## QUIT; \n
## - pārliecināties par HPA darbību (3 termināli atsevišķi): \n
##  kubectl get hpa laravel --watch \n
##  kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://laravel.ltv.lv/; done" \n
##  kubectl run -i --tty load-generator2 --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.1; do wget -q -O- http://laravel.ltv.lv/; done" \n
