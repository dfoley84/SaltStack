base:
  'roles:nodejs-server':
    - match: grain
    - package
    - service
  'roles:nginx-server':
    - match: grain
    - nginx-server
