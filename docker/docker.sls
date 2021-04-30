{% if grains.os_family == 'RedHat' %}
{% set update = 'yum' %}
{% set keys = {{ pillar['Docker']['Keys']['RedHat'] }} %}
{% set config = {{ pillar['Docker']['Repo']['RedHat'] }} %}

{% elif grains.os_family == 'Debian' %}
{% set update = 'apt' %}
{% set keys = {{ pillar['Docker']['Keys']['Ubuntu'] }} %}
{% set config = {{ pillar['Docker']['Repo']['Ubuntu'] }} %}
{% set Docker_Version = {{ pillar['Docker']['Version']['Ubuntu'] }} %}
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
    - version: {{ Docker_Version }}

Install_Docker:
  pkg.installed:
    - name: docker-ce

Docker_Run:
  service.running:
    - name: docker
    - require:
        - pkg: docker-ce

