base:


updates:
  win_update.installed:
    - categories:
      - 'Critical Updates'
      - 'Security Updates'
    - skips:
      - downloaded
  win_update.downloaded:
    - categories:
      - 'Updates'
    - skips:
      - downloaded