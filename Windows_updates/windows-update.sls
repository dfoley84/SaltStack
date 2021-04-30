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
 salt -G 'roles:windows' win_update.install_updates categories="['Critical Updates', 'Security Updates']"
 salt '*' win_wua.list categories=['Critical Updates','Update Rollups','Windows 2012'] install=True
