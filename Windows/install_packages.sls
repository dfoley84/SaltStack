{% set packages = ['firefox','adobereader','winscp','git','atom','postman','zoom','slack','python','golang'] %}

{% for package in packages %}
chocolatey.install:
  - name: {{ package }}
{% endfor %}
