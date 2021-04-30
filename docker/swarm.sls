{% if grains.os_family == 'RedHat' %}
{% set update = 'yum' %}
{% set config = 'yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo' %}
Pre_Request:
  pkg.installed:
    pkg.latest:
      - pkgs:
        - yum-util
        - device-mapper-persistent-data
        - lvm2

{% elif grains.os_family == 'Debian' %}
{% set update = 'apt' %}
{% set keys = 'curl -K -fsSL https://download.docker.com/linux/ubuntu/gpg >> text.txt | sudo apt-key add text.txt' %}
{% set config = 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"' %}
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

Docker_Run:
  service.running:
    - name: docker
    - require:
        - pkg: docker-ce

{%- if 'Master' in grains['role'] %}

Python:
  pkg.installed:
    - name: python-pip

Pip_install:
  cmd.run:
    - name: 'pip install -U docker'

Docker_Swarm:
  cmd.run:
    - name: 'docker swarm init --advertise-addr {{ pillar['docker']['swarm']['advertise_addr'] }}'


docker_swarm_grains_publish:
  module.run:
    - name: mine.update
    - watch:
      - cmd: docker_swarm_init

{%- set join_token = [] %}
# Globals can't be overrided from for cycle
{%- for node_name, node_grains in salt['mine.get']('*', swarm.mine_function).iteritems() %}
{%- if node_grains.get("docker_swarm_AdvertiseAddr", None) == swarm.master.host|string+":"+swarm.master.port|string %}
{%- do join_token.append(node_grains.get('docker_swarm_tokens').get(swarm.role, "unknown")) %}
{%- break %}
{%- endif %}
{%- endfor %}
{%- set join_token = swarm.get('join_token', {}).get(swarm.role, join_token[-1] if join_token else 'unknown') %}

{%- elif 'Worker' in grains['role'] %}

Join_Swarm:
  cmd.run:
    - name: 'docker swarm join --token {{ join_token }} {{ pillar['docker]['swarm']['advertise_addr'] }}:{{ pillar['docker]['swarm']['bind']['port'] }}


{% endif %}


