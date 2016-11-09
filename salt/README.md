
master_srv_salt -> salt_master:/srv/salt/
master_srv_pillar -> salt_master:/srv/pillar/


# to make the tar.gz'name same with the jdk name in jdk/init.sls
[root@kvm-005770 files]# pwd
/srv/salt/jdk/files
[root@kvm-005770 files]# mv jdk-8u66-linux-x64.tar.gz jdk1.8.0_66.tar.gz

[root@kvm-005770 files]# pwd
/srv/salt/maven/files
[root@kvm-005770 files]# mv apache-maven-3.3.9-bin.tar.gz apache-maven-3.3.9.tar.gz


# you can run the command below to install jdk on minion kvm-005772.novalocal
[root@kvm-005770 salt]# salt 'kvm-005772.novalocal' state.sls jdk
[root@kvm-005770 salt]# salt -L 'kvm-005775.novalocal kvm-005776.novalocal' state.sls jdk

[root@kvm-005770 salt]# salt 'kvm-005772.novalocal' state.sls maven
[root@kvm-005770 salt]# salt -L 'kvm-005775.novalocal kvm-005776.novalocal' state.sls maven





