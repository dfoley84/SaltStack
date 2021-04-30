{% if grains['os_family'] == 'Ubuntu' %}

Install_ClamAV:
  - cmd.run:
    name: 'apt install clamav clamav-daemon -y'



{% endif %}
{% if grains['os_family'] == 'RedHat' %}


{% endif %}
