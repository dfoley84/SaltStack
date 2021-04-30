nginx:
  pkg.installed: []
  service.running:
    watch:
      file: /etc/nginx.conf

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://load-balance/nginx.conf
nginx:
  pkg.installed: []
  service.running:
    watch:
      file: /etc/nginx.conf

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://load-balance/nginx.conf
