copy_files:
  file.recurse:
    - source: salt://software/OCS_Installer/
    - name: C:\ProgramData\OCS
    - makedirs: True

{%- if 'vapshared' in grains['role'] %}
{% if grains['kernel'] == 'Windows' %}
install_VAP_ocsagent:
  cmd.run:
    - name: '{{ pillar['VAP_OSC'] }}'
    - cwd: C:\ProgramData\OCS
    - unless: 'sc query "OCS Inventory Service"'
{% endif %}
{% endif %}

{%- if 'dbpshared' in grains['role'] %}
{% if grains['kernel'] == 'Windows' %}
install_VAP_ocsagent:
  cmd.run:
    - name: {{ pillar['DBP_OSC'] }}
    - cwd: C:\ProgramData\OCS
    - unless: 'sc query "OCS Inventory Service"'
{% endif %}
{% endif %}

{%- if 'lopshared' in grains['role'] %}
{% if grains['kernel'] == 'Windows' %}
install_VAP_ocsagent:
  cmd.run:
    - name: {{ pillar['LOP_OSC'] }}
    - cwd: C:\ProgramData\OCS
    - unless: 'sc query "OCS Inventory Service"'
{% endif %}
{% endif %}

{%- if 'mopshared' in grains['role'] %}
{% if grains['kernel'] == 'Windows' %}
install_VAP_ocsagent:
  cmd.run:
    - name: {{ pillar['MOP_OSC'] }}
    - cwd: C:\ProgramData\OCS
    - unless: 'sc query "OCS Inventory Service"'
{% endif %}
{% endif %}

clean_files:
  file.recurse:
    - source: salt://software/OCS_Installer/
    - name: C:\ProgramData\OCS\
    - clean: True
    - makedirs: False

{% elif grains['kernel'] == 'Linux' %}
create_dir:
  file.directory:
    - name: /opt/ocsinventory

create_dirbase:
  file.directory:
    - name: /opt/ocsfiles

copy_files:
  file.recurse:
    - source: salt://ocslinux/
    - name: /opt/ocsfiles
    - makedirs: True

extract_ocsagent:
  cmd.run:
    - name: tar -zxvf ocsinventory-agent-234-48-v3.tar.gz -C /
    - cwd: /opt/ocsfiles

install_ocsagent:
  cmd.run:
    - name: ./ocs_agent_configurator.pl 58
    - cwd: /opt/ocsinventory/scripts

run_ocsagent:
  cmd.run:
    - name: ./ocsinventory-agent -f
    - cwd: /opt/ocsinventory
    
  {% endif %}
