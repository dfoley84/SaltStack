Change-Suffix:
  cmd.run:
    - shell: powershell
    - name: 'Set-DnsClientGlobalSetting -SuffixSearchList @("")'
