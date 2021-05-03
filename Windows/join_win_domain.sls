Windows_Join_Domain:
  module.run:
    - name: win_system.join_domain
    - domain: {{ pillar['Domain'] }}
    - user: {{ pillar['User'] }}
    - passwd: {{ pillar['PSWD'] }}
    - account_ou: {{ pillar['location'] }}
    - account_exists: false
    - restart: true 
