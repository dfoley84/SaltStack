create_dir:
  file.directory:
    - name: C:\sentinel

copy_files1:
  file.recurse:
    - source: salt://sentinel/
    - name: C:\sentinel\
    - makedirs: True

{%- if 'vapshared' in grains['role'] %}
uninstall:
  cmd.script:
    - source: c:/sentinel/endpoint.ps1
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"

LRS_Install:
  cmd.run:
    - name: 'SentinelOne-windows-Denali_windows_v2_7_4_6510.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['VAP_SQUID'] }}/Q /FORCERESTART'
    - cwd: C:\sentinel

{%- elif 'dbpshared' in grains['role'] %}
uninstall:
  cmd.script:
    - source: c:/sentinel/endpoint.ps1
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"

LRS_Install:
  cmd.run:
    - name: 'SentinelOne-windows-Denali_windows_v2_7_4_6510.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['DBP_SQUID'] }}/Q /FORCERESTART'
    - cwd: C:\sentinel

{%- elif 'mopshared' in grains['role'] %}
uninstall:
  cmd.script:
    - source: c:/sentinel/endpoint.ps1
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"

LRS_Install:
  cmd.run:
    - name: 'SentinelOne-windows-Denali_windows_v2_7_4_6510.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['MOP_SQUID'] }}/Q /FORCERESTART'
    - cwd: C:\sentinel

  {%- elif 'lopshared' in grains['role'] %}
  uninstall:
    cmd.script:
      - source: c:/sentinel/endpoint.ps1
      - shell: powershell
      - env:
        - ExecutionPolicy: "bypass"

  LRS_Install:
    cmd.run:
      - name: 'SentinelOne-windows-Denali_windows_v2_7_4_6510.exe /SITE_TOKEN={{ pillar['VAP_S1_TOKEN'] }} /SERVER_PROXY={{ pillar['LOP_SQUID'] }}/Q /FORCERESTART'
      - cwd: C:\sentinel
  {% end %}
