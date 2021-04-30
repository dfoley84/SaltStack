Disable_IPV6:
  cmd.run:

    #
    - shell: powershell
    - name: 'Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6'
