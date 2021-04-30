Get-AD:
  cmd.run:
    - name: 'Get-ADComputer -Identity {{ pillar['server'] }} -Properties *'
    - shell: powershell
