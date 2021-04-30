create_dir:
  file.directory:
    - name: C:\Program Files\winlogbeat

copy_winlog:
  file.recurse:
    - source: salt://elasticsearch/winlogbeat/
    - target: C:\Program Files\winlogbeat\
    - makedirs: True

Install_winlog:
  cmd.script:
    - cwd: C:\Program Files\winlogbeat\
    - name: install-service-winlogbeat.ps1
    - shell: powershell
    - env:
      - ExecutionPolicy: "UnRestricted"
    - unless: 'sc query "winlogbeat"'

StartServices:
  cmd.run:
    - name: Start-Service winlogbeat
    - cwd: C:\Program Files\winlogbeat
