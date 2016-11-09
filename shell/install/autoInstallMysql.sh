#!/bin/bash
#用yum ,可以删除关联依赖
sudo yum -y remove mysql-libs-5.1.71*
sudo rpm -iv MySQL-client-5.5.24-1.rhel4.x86_64.rpm
sudo rpm -iv MySQL-devel-5.5.24-1.rhel4.x86_64.rpm
sudo rpm -iv MySQL-server-5.5.24-1.rhel4.x86_64.rpm
echo '启动服务/etc/init.d/mysql start'
echo '使用mysqld_safe &命令查看日志'
echo '在mysql系统外，使用mysqladmin修改密码'
echo '# mysqladmin -u root -p password "test123"'
echo 'Enter password: 【输入原来的密码】'
echo 'mysql -u root -p登录控制台'
