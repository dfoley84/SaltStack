create_Zabbix_Directory:
  file.directory:
    - name: C:\ProgramData\Zabbix

create_Zabbix_Directory1:
  file.directory:
    - name: C:\Program Files\Zabbix

copy_files1:
  file.recurse:
    - source: salt://software/zabbix/ProgramData/
    - name: C:\ProgramData\Zabbix\
    - makedirs: True

ProgramData1:
  file.managed:
    - source: salt://software/zabbix/ProgramData/zabbix_agentd.d/ot_hostname_win.conf
    - name: C:\ProgramData\Zabbix\zabbix_agentd.d\ot_hostname_win.conf
    - template: jinja

copy_files:
  file.recurse:
    - source: salt://zabbix/ProgramFiles/
    - name: C:\Program Files\Zabbix\
    - makedirs: True

install_zabbix_agent:
  cmd.run:
    - name: 'zabbix_agentd.exe --config C:\ProgramData\Zabbix\zabbix_agentd.conf --install'
    - cwd: C:\Program Files\Zabbix\bin\win64
    - unless: 'sc query "Zabbix Agent"'

run_zabbix_agent:
  cmd.run:
    - name: 'zabbix_agentd.exe --start'
    - cwd: C:\Program Files\Zabbix\bin\win64\
