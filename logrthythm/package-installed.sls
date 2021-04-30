{% if grains['os_family'] == 'Windows' %}
create_dir:
  file.directory:
    - name: C:\logrhythm\

LRS_File:
  file.managed:
    - name: c:/logrhythm/LRSystemMonitor_64_7.4.2.8003.exe
    - source: salt://logrhythm/LRSystemMonitor_64_7.4.2.8003.exe

{% if grains['fqdn'].startswith('VAP') %}
Install_VAP:
  cmd.run:
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['VAPSHARED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
    - cwd: C:\logrhythm

{% elif grains['fqdn'].startswith('DBP') %}
Install_MOP:
  cmd.run:
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['DBPSHARED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
    - cwd: C:\logrhythm

{% elif grains['fqdn'].startswith('LOP') %}
Install_LOP:
  cmd.run:
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['LOPSAHRED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
    - cwd: C:\logrhythm

{% elif grains['fqdn'].startswith('MOP') %}
Install_MOP:
  cmd.run:
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['MOPSHARED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
    - cwd: C:\logrhythm
{% endif %}

/srv/salt/logrhythm/proxy.ini:
  file.managed:
    - source: salt://logrhythm/proxy.ini
    - name: C:\Program Files\LogRhythm\LogRhythm System Monitor\config\proxy.ini
    - template: jinja

/srv/salt/logrhythm/scsm.ini:
  file.managed:
    - source: salt://logrhythm/scsm.ini
    - name: C:\Program Files\LogRhythm\LogRhythm System Monitor\config\scsm.ini
    - template: jinja

Start Service:
  cmd.run:
    - name: 'net start scsm'
{% endif %}

{%- if grains['os_family'] == 'Ubuntu' %}
Ubuntu_rsyslog:
  file.managed:
    - source: salt://logrhythm/rsyslog.conf
    - name: /etc/rsyslog.conf

service.restart rsyslog:
  module.wait:
    - name: service.restart
    - m_name: rsyslog
    - watch:
      - file: /etc/rsyslog.conf

{% endif %}
