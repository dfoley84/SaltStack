{% if grains.os_family == 'RedHat' %}
{% set name = 'httpd' %}
{% set dest = '/home/httpd/html/'%}}
{% elif grains.os_family == 'Debian' %}
{% set name = 'apache2' %}
{% set dest = '/var/www/html/' %}}
{% endif %}

 apache:
  pkg.installed:
    - name: {{ name }}

 http_file:
   file.recurse:
     - name: {{ dest }}
     - source: salt://webservers/templates/apache/
