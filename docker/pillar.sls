Docker:
  Keys:
    Redhat: 'yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo'
    Ubuntu: 'curl -K -fsSL https://download.docker.com/linux/ubuntu/gpg >> text.txt | sudo apt-key add text.txt'
  Repo:
    Redhat: 'yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.33-1.git86f33cd.el7.noarch.rpm'
    Ubuntu: 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"'
  Version:
    Redhat: '17.09.ce-1.el7.centos'
    Ubuntu: '17.09.0~ce-0~ubuntu'

ElasticSearch:
  Keys:
    Redhat: 'rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch'
    Ubuntu: 'wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -'
  Repo:
    RedHat:  
    Ubuntu: '"deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list'

Kuberenets:
  Keys:
    Redhat: 'cat <<EOF > /etc/yum.repos.d/kubernetes.repo
            [kubernetes]
            name=Kubernetes
            baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
            enabled=1
            gpgcheck=1
            repo_gpgcheck=1
            gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
            EOF'
    Ubuntu: 'curl -K -s https://packages.cloud.google.com/apt/doc/apt-key.gpg >> kube.txt | sudo apt-key add kube.txt'
  Repo:
    Redhat: 'sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config'
    Ubuntu: 'sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"'

  
