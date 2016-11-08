jdk-file:
  file.managed:
    - source: {{pillar['jdk']['srvpath']}}/{{pillar['jdk']['name']}}.tar.gz
    - name: {{pillar['jdk']['homepath']}}/{{pillar['jdk']['name']}}.tar.gz
    - makedirs: True
    - include_empty: True

jdk-install:
  cmd.run:
    - name: '/bin/tar -zxvf {{pillar['jdk']['name']}}.tar.gz'
    - cwd: /opt/java
    - unless: 'test -e {{pillar['jdk']['name']}}'
    - require:
      - file: jdk-file

jdk-rmzip:
  file.absent:
    - name: {{pillar['jdk']['homepath']}}/{{pillar['jdk']['name']}}.tar.gz

/etc/bashrc:
  file.append:
    - text:
      - export JAVA_HOME={{pillar['jdk']['homepath']}}/{{pillar['jdk']['name']}}
      - export PATH=$JAVA_HOME/bin:$PATH

jdk-effect:
  cmd.run:
    - name: 'source /etc/bashrc'

#reload PATH
{% set git_dir = pillar['jdk']['homepath'] ~ '/' ~ pillar['jdk']['name'] %}
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
