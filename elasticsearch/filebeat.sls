{% if grains.os_family == 'RedHat' %}
{% set update = 'yum' %}
{% set Download_Package_FileBeat = salt['pillar.get']('ElastciSearch:Filebeat:RedHat') %}
{% set version = '7.2.0'%}
{% set rpm_deb = 'x86_64.rpm' %}
{% set home = 'ec2' %}
{% elif grains.os_family == 'Debian' %}
{% set update = 'apt' %}
{% set Download_Package_FileBeat = salt['pillar.get']('ElastciSearch:Filebeat:Ubuntu') %}
{% set version = '7.2.0'%}
{% set rpm_deb = 'amd64.deb' %}
{% set home = 'ubuntu' %}

Download_Filebeat:
  cmd.run:
    - name: {{ Download_Package_FileBeat }}
    - creates: /home/{{ Home }}/filebeat-{{ version }}-{{ rpm_deb }}

Unpackage:
  cmd.run:
    - name: dpkg -i filebeat-{{ version }}-{{ rpm_deb }}
    - cwd: /home/{{ home }}/

filebeat_file:
  file.managed:
    - source: salt://sent/filebeat.yml
    - name: /etc/filebeat/filebeat.yml

Enable_filebeat:
  cmd.run:
    - name: filebeat modules enable system
    - cwd: /etc/filebeat

enable_filebeat1:
  cmd.run:
    - name: filebeat modules enable iptables

Start_Service:
  cmd.run:
    - name: service filebeat start
