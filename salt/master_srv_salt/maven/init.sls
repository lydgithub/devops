maven-file:
  file.managed:
    - source: {{pillar['maven']['srvpath']}}/{{pillar['maven']['name']}}.tar.gz
    - name: {{pillar['maven']['homepath']}}/{{pillar['maven']['name']}}.tar.gz
    - makedirs: True
    - include_empty: True

maven-install:
  cmd.run:
    - name: '/bin/tar -zxvf {{pillar['maven']['name']}}.tar.gz'
    - cwd: /opt/maven
    - unless: 'test -e {{pillar['maven']['name']}}'
    - require:
      - file: maven-file

maven-rmzip:
  file.absent:
    - name: {{pillar['maven']['homepath']}}/{{pillar['maven']['name']}}.tar.gz

/etc/bashrc:
  file.append:
    - text:
      - export M2_HOME={{pillar['maven']['homepath']}}/{{pillar['maven']['name']}}
      - export PATH=$M2_HOME/bin:$PATH

maven-effect:
  cmd.run:
    - name: 'source /etc/bashrc'

#reload PATH
{% set git_dir = pillar['maven']['homepath'] ~ '/' ~ pillar['maven']['name'] %}
{% set env_path = salt['environ.get']('PATH') %}
{% set env_path = env_path ~ ':' ~ git_dir ~ '/bin' %}

env-path-exists:
  file.exists:
    - name: {{ git_dir }}

environ-upenv-path:
  environ.setenv:
    - name: PATH
    - value: {{ env_path }}
    - update_minion: True
#    - onchanges:
#      - file: env-path-exists
