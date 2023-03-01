#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

curl_install(){
sudo apt install curl

}


set_hostname(){
sudo hostnamectl hostname k3s-singlenode
}

kubectl_install(){
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

helm_install(){                                                                                                                                                                                                    
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash                                                                                                                                    
}                                                                                                                                                                                                                  
                                                                                                                                                                                                                   
k3s_install(){                                                                                                                                                                                                     
                                                                                                                                                                                                                   
curl -sfL https://get.k3s.io |  INSTALL_K3S_CHANNEL=v1.24.9-rc1+k3s1  INSTALL_K3S_EXEC="--write-kubeconfig=$(pwd)/.kube/config --write-kubeconfig-mode=644" K3S_TOKEN=SECRET sh -s - server --cluster-init         
}                                                                                                                                                                                                                  
                                                                                                                                                                                                                   
set_hostname                                                                                                                                                                                                       
kubectl_install                                                                                                                                                                                                    
helm_install                                                                                                                                                                                                       
k3s_install
