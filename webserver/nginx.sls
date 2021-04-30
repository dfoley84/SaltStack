nginx:
  pgk:
    - installed
  service.running:
    - enable: True

/var/www/html/index.html:
  file.managed:
    - template: jinja
    - source: salt://webservers/templates/index.html.tmpl
