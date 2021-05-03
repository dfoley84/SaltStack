Get-DSC:
  cmd.run:
    - name: 'Set-DscLocalConfigurationManager -Path \\  -Verbose -Force'
    - shell: powershell
