jdk-file:
  file.managed:
    - source: salt://jdk/files/jdk-8u66-linux-x64.tar.gz
    - name: /opt/java/jdk-8u66-linux-x64.tar.gz
    - makedirs: True
    - include_empty: True

jdk-install:
  cmd.run:
    - name: '/bin/tar -zxvf jdk-8u66-linux-x64.tar.gz && /bin/ln -s jdk1.8.0_66 latest '
    - cwd: /opt/java
    - unless: 'test -e jdk1.8.0_66'
    - require:
      - file: jdk-file

jdk-rmzip:
  file.absent:
    - name: /opt/java/jdk-8u66-linux-x64.tar.gz

/etc/bashrc:
  file.append:
    - text:
      - export JAVA_HOME=/opt/java/latest
      - export PATH=$JAVA_HOME/bin:$PATH

jdk-effect:
  cmd.run:
    - name: 'source /etc/bashrc'
