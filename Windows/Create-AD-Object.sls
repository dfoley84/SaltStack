Creating_AD_Object:
  cmd.run:
  {%- if pillar['Domain'].startswith('sa') %}
    - name: 'New-ADComputer -Name {{ pillar['server'] }} -SamAccountName {{ pillar['server'] }} -Path "OU=Servers,OU={{ pillar['location'] }},DC=sa,DC=,DC="'
    - shell: powershell
  {%- elif pillar['Domain'].startswith('mea') %}
    - name: 'New-ADComputer -Name {{ pillar['server'] }} -SamAccountName {{ pillar['server'] }} -Path "OU=Servers,OU={{ pillar['location'] }},DC=mea,DC=,DC="'
    - shell: powershell
  {%- elif pillar['Domain'].startswith('corp') %}
    - name: 'New-ADComputer -Name {{ pillar['server'] }} -SamAccountName {{ pillar['server'] }} -Path "OU=Servers,OU={{ pillar['location'] }},DC=corp,DC=,DC="'
    - shell: powershell
  {%- elif pillar['Domain'].startswith('ap') %}
    - name: 'New-ADComputer -Name {{ pillar['server'] }} -SamAccountName {{ pillar['server'] }} -Path "OU=Servers,OU={{ pillar['location'] }},DC=ap,DC=,DC="'
    - shell: powershell
  {%- elif pillar['Domain'].startswith('eu') %}
    - name: 'New-ADComputer -Name {{ pillar['server'] }} -SamAccountName {{ pillar['server'] }} -Path "OU=Servers,OU={{ pillar['location'] }},DC=eu,DC=,DC="'
    - shell: powershell
  {%- elif pillar['Domain'].startswith('np') %}
    - name: 'New-ADComputer -Name {{ pillar['server'] }} -SamAccountName {{ pillar['server'] }} -Path "OU=Servers,OU={{ pillar['location'] }},DC=np,DC=,DC="'
    - shell: powershell
  {% endif %}
