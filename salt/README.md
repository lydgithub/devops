

# to make the tar.gz'name same with the jdk name in jdk/init.sls
[root@kvm-005770 files]# pwd
/srv/salt/jdk/files
[root@kvm-005770 files]# mv jdk-8u66-linux-x64.tar.gz jdk1.8.0_66.tar.gz

# you can run the command below to install jdk on minion kvm-005772.novalocal
[root@kvm-005770 salt]# salt 'kvm-005772.novalocal' state.sls jdk




