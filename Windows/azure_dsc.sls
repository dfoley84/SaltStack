Get-DSC:
  cmd.run:
    - name: 'Set-DscLocalConfigurationManager -Path \\<URL>\DSCSource\AA-DSC\DscMetaConfigs\Approved -Verbose -Force'
    - shell: powershell
