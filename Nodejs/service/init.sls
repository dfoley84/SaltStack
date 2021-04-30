include:
  - site

supervisor:
  pkg.installed:
    - require:
      - sls: site
  service.running:
    - watch:
      - file: /etc/supervisor/conf.d/site.conf:

/etc/supervisor/conf.d/site.conf:
  file.managed:
    - source: salt://service/supervisor.conf
    - require:
      - pkg: supervisor
      
