{% set git_dir = '/opt/java/jdk1.8.0_66' %}
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
