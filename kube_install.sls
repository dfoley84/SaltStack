{% if grains.os_family == 'RedHat' %}

{% elif grains.os_family == 'Debian' %}
{% set update = 'apt' %}
{% set keys = 'curl -K -fsSL https://download.docker.com/linux/ubuntu/gpg >> text.txt | sudo apt-key add text.txt' %}
{% set config = 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"' %}
{% set kube_key = 'curl -K -s https://packages.cloud.google.com/apt/doc/apt-key.gpg >> kube.txt | sudo apt-key add kube.txt' %}
{% set kube_repo = 'sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"'  %}
{% set kube_pkg = 'sudo apt-get install -y kubelet=1.12.7-00 kubeadm=1.12.7-00 kubectl=1.12.7-00' %}
{% endif %}

Docker_key:
  cmd.run:
    - name: {{ keys }}

Docker_Repo:
  cmd.run:
    - name: {{ config }}

Update_Linux:
  cmd.run:
    - name: {{ update }} update

Install_Docker:
  pkg.installed:
    - name: docker-ce
    - version: 18.06.1

Docker_Run:
  service.running:
    - name: docker
    - require:
        - pkg: docker-ce

Kubernetes_key:
  cmd.run:
    - name: {{ kube_key }}

Kubernetes_Repo:
  cmd.run:
    - name: {{ kube_repo }}

Kubernetes_Kubelet:
  pkg.installed:
    - name: kubelet
    - version: 1.12.7-00

Kubernetes_Kubeadm:
  pkg.installed:
    - name: kubeadm
    - version: 1.12.7-00

Kubernetes_Kubectl:
  pkg.installed:
    - name: kubectl
    - version: 1.12.7-00

Kubernetes_Run:
  service.running:
    - name: kubeadm
    - version: 1.12.7-00
 
Kubernetes_Bridge:
  cmd.run:
    - name: 'echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf'
    - name: 'sudo sysctl -p'

{%- if 'KubeMaster' in grains['role'] %}
Kubernetes_CIDR:
  cmd.run:
    - name: 'sudo kubeadm init --pod-network-cidr=172.168.10.0/24 | tee ./kubeNetwork.txt'

Kubernetes_Mkdir:
  cmd.run:
    - names:
      - 'mkdir -p $HOME/.kube'
      - 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config'
      - 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'

Kubernetes_Flannel:
  cmd.run:
    - name: 'kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml'
{% endif %}
