deploy the http.conf file:
  file.managed:
    - name: /etc/metricbeat/modules.d/elasticsearch.yml
    - source: salt://elasticsearch.yml
