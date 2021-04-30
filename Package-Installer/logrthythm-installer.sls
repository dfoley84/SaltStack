create_dir:
  file.directory:
    - name: C:\bin

LRS_File:
  file.managed:
    - name: c:\bin\LRSystemMonitor_64_7.4.2.8003.exe
    - source: salt://software/logrhythm/LRSystemMonitor_64_7.4.2.8003.exe

{%- if 'vapshared' in grains['role'] %}
Install_LR:
  cmd.run:
  {%- if 'vapshared' in grains['role'] %}
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['VAPSHARED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
  {%- elif 'dbpshared' in grains['role'] %}
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['DBPSHARED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
  {%- elif 'lopshared' in grains['role'] %}
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['LOPSAHRED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
  {%- elif 'mopshared' in grains['role'] %}
    - name: 'LRSystemMonitor_64_7.4.2.8003.exe /s /v" /qn ADDLOCAL=System_Monitor,RT_FIM_Driver HOST={{ pillar['MOPSHARED_PRIM'] }} SERVERPORT=443 CLIENTADDRESS={{ grains['fqdn_ip4'][0] }} CLIENTPORT=0'
{% endif %}
    - cwd: C:\bin
    - unless: 'sc query scsm'

/srv/salt/logrhythm/proxy-recommind_prod_virginia-1.ini:
  file.managed:
    - source: salt://software/logrhythm/proxy.ini
    - name: C:\Program Files\LogRhythm\LogRhythm System Monitor\config\proxy.ini
    - template: jinja

/srv/salt/logrhythm/scsm-recommind_prod_virginia.ini:
  file.managed:
    - source: salt://software/logrhythm/scsm.ini
    - name: C:\Program Files\LogRhythm\LogRhythm System Monitor\config\scsm.ini
    - template: jinja

Start Service:
  cmd.run:
    - name: 'net start scsm'

Enable Service:
  cmd.run:
    - name: 'sc config scsm start=auto'

restart_on_Faiulre:
  cmd.run:
    - name: 'sc failure scsm actions= restart/1000/restart/5000/restart/10000 reset= 3'

Remove_file:
   cmd.run:
      - name: 'del /f C:\bin\lrsystemmonitor_64_7.4.2.8003.exe'
