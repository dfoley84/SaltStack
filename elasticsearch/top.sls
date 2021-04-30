base:
  'os:Windows':
    - match: grain
    - winlogbeat
  'os:Ubuntu':
    - match: grain
    - filebeat
