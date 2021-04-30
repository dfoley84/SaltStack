{% if grains['os'] == 'RedHat' %}

Download_Filebeat:
  cmd.run:
    - name: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.0.1-x86_64.rpm
    - creates: /home/metricbeat-7.0.1-x86_64.rpm

Unpackage:
  cmd.run:
    - name: sudo rpm -vi metricbeat-7.0.1-x86_64.rpm
    - cwd: /home

{% elif grains['os'] == 'Ubuntu' %}
Download_Filebeat:
  cmd.run:
    - name: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.0.1-amd64.deb
    - creates: /home/metricbeat-7.0.1-amd64.deb

Unpackage:
  cmd.run:
    - name: sudo dpkg -i metricbeat-7.0.1-amd64.deb
    - cwd: /home
{% endif %}

filebeat_file:
  file.managed:
    - source: salt://Elk/metricbeat.yml
    - name: /etc/metricbeat/metricbeat.yml
    - template: jinja

Enable_System:
  cmd.run:
    - name: sudo metricbeat modules enable system
    - cwd: /etc/metricbeat

Enable_Metricbeat:
  cmd.run:
    - name: sudo metricbeat setup
    - cwd: /etc/metricbeat

Start_Service:
  cmd.run:
    - name: sudo service metricbeat start
