{% if grains['os_family'] == 'RedHat' %}
  {% set package = 'httpd' %}
{% elif grains['os_family'] == 'Debian' %}
  {% set package = 'apache2' %}
{% endif %}

make sure apache is running:
  service.running:
    - name: {{ package }}
    - enable: True
    - watch:
      - file: sync mod_status.conf
      - file: sync mod_status.load
    - require:
      - pkg: install_apache

install_apache:
  pkg.installed:
    - name: {{ package }}
#    - version: '< 2.4.6-19'

sync mod_status.conf:
  file.managed:
    - name: /etc/{{ package }}/conf.modules.d/mod_status.conf
    - source: salt://mod_status.conf
    - user: root
    - group: root
    - mode: 600

sync mod_status.load:
  file.managed:
    - name: //etc/{{ package }}/conf.modules.d/00-mod_status.conf
    - source: salt://mod_status.load
    - user: root
    - group: root
    - mode: 600
