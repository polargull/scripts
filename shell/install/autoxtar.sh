#!/bin/bash
. ./constant
print() {
	echo '------------------------------'
	echo 'XTAR LOCAL HOME:'${LOCAL_HOME}
	echo 'USER HOME:'${USER_HOME}
	echo 'LN HOME:'${LN_HOME}
	echo 'TOMCAT:'${TOMCAT}
	echo 'Jenkins:'${LN_HOME}/tomcat/webapps
	echo 'MAVEN:'${MAVEN}
	echo 'NEXUS:'${NEXUS}
	echo 'JDK:'${JDK}
	echo '------------------------------'
	echo '请编辑 vim /etc/sysconfig/iptables'
	echo '追加-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT'
	echo '追加-A INPUT -m state --state NEW -m tcp -p tcp --dport 8081 -j ACCEPT'
	echo '追加-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT'
	echo '执行service iptables restart'
	echo 'Done !!!'
}
clean() {
	rm -rf ${LN_HOME} ${LOCAL_HOME}
}
mk_ln_local_dir() {
	mkdir ${LN_HOME} ${LOCAL_HOME}
}
xtar() {
	for tar in *.tar.gz;  do tar -zxvf $tar -C ${LOCAL_HOME}; done
}
mkln() {
	ln -s ${LOCAL_HOME}/${MAVEN} ${LN_HOME}/maven
	ln -s ${LOCAL_HOME}/${TOMCAT} ${LN_HOME}/tomcat
	ln -s ${LOCAL_HOME}/${NEXUS} ${LN_HOME}/nexus
	ln -s ${LOCAL_HOME}/${JDK} ${LN_HOME}/java
}
clean_env() {
	sed -i '/export/'d ~/.bashrc
}
conf_env() {
	echo 'export M2_HOME='${LN_HOME}'/maven'|tee -a ${USER_ENV}
	echo "export MAVEN_OPTS='-Xms128m -Xmx512m'"|tee -a ${USER_ENV}
	echo "export JAVA_OPTS=-'Xms128m -Xmx512m'"|tee -a ${USER_ENV}
	echo 'export NEXUS_HOME='${LN_HOME}'/nexus'|tee -a ${USER_ENV}
	echo 'export JAVA_HOME='${LN_HOME}'/java'|tee -a ${USER_ENV}
	echo 'export NEXUS_HOME_BIN=$NEXUS_HOME/bin'|tee -a ${USER_ENV}
	echo 'export JAVA_BIN=$JAVA_HOME/bin'|tee -a ${USER_ENV}
	echo 'export JAVA_LIB=$JAVA_HOME/lib'|tee -a ${USER_ENV}
	echo 'export CLASSPATH=.:$JAVA_LIB/tools.jar:$JAVA_LIB/dt.jar'|tee -a ${USER_ENV}
	echo 'export PATH=$JAVA_BIN:$PATH:$NEXUS_HOME_BIN:$M2_HOME/bin'|tee -a ${USER_ENV}
	source ${USER_ENV}
}
#cp -a jenkins.war ${LN_HOME}/tomcat/webapps/

clean
mk_ln_local_dir
xtar
mkln
clean_env
conf_env
print
