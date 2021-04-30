copy_files:
  file.recurse:
    - source: salt://software/Sentinel_Installer/
    - name: C:\package_installer\
    - makedirs: True

{%- if 'vapshared' in grains['role'] %}
LRS_Install:
  cmd.run:
    - name: 'SentinelAgent_windows_v3_0_2_35.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['VAP_SQUID'] }}/Q /FORCERESTART'
    - cwd: C:\package_installer

{%- elif 'dbpshared' in grains['role'] %}
LRS_Install:
  cmd.run:
    - name: 'SentinelAgent_windows_v3_0_2_35.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['DBP_SQUID'] }}/Q /FORCERESTART'
    - cwd: C:\package_installer

{%- elif 'mopshared' in grains['role'] %}
LRS_Install:
  cmd.run:
    - name: 'SentinelAgent_windows_v3_0_2_35.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['MOP_SQUID'] }}/Q /FORCERESTART'
    - cwd: C:\package_installer

  {%- elif 'lopshared' in grains['role'] %}
    cmd.run:
      - name: 'SentinelAgent_windows_v3_0_2_35.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['LOP_SQUID'] }}/Q /FORCERESTART'
      - cwd: C:\package_installer
  {% end %}

Remove_files:
  file.recurse:
    - source: salt://software/Sentinel_Installer/
    - name: C:\package_installer\
    - makedirs: False
    - clean: True
