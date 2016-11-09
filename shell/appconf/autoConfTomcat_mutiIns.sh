#!/bin/bash
. ~/dl/constant

TOMCAT=${LN_HOME}/tomcat
TOMCAT_INST_HOME=${TOMCAT}/inst
mkdir -p ${TOMCAT_INST_HOME}
mkdir -p ${TOMCAT}/common_inst_file

rm -rf ${TOMCAT}/webapps
rm -rf ${TOMCAT}/LICENSE
rm -rf ${TOMCAT}/NOTICE
rm -rf ${TOMCAT}/RUNNING.txt
rm -rf ${TOMCAT}/RELEASE-NOTES
rsync -av --exclude inst --exclude common_inst_file --exclude bin --exclude lib ${TOMCAT}/* ${TOMCAT}/common_inst_file 
rm -rf ${TOMCAT}/conf
rm -rf ${TOMCAT}/work
rm -rf ${TOMCAT}/temp
rm -rf ${TOMCAT}/logs
INSTANTS=(jenkins.polar.com webapp1)
count=1
for inst in ${INSTANTS[*]};
do
echo "实例名"$count":"${inst}
TOMCAT_INST=$TOMCAT_INST_HOME/$inst
mkdir -p $TOMCAT_INST
SITE_INST=${SITE_DEV}/${inst}
mkdir -p $SITE_INST
echo "实例目录："$TOMCAT_INST
echo "站点应用目录："$SITE_INST
echo "端口号："806$count
echo "--------------"
cp -a ${TOMCAT}/common_inst_file/* ${TOMCAT_INST}
sed -i 's/<Server port=\"8005\"/<Server port=\"800'$count'\"/g' ${TOMCAT_INST}/conf/server.xml
sed -i 's/<Connector port=\"8080\"/<Connector port=\"806'$count'\"/g' ${TOMCAT_INST}/conf/server.xml
sed -i 's/<Connector port=\"8009\"/<Connector port=\"80'$count'9\"/g' ${TOMCAT_INST}/conf/server.xml
sed -i 's#appBase="webapps"#appBase="'$SITE_DEV'/'${inst}'"#g' ${TOMCAT_INST}/conf/server.xml
((count+=1))
# echo 's/appBase=\"webapps\"/appBase=\"'$SITE_DEV'/'${inst}'/deploy"/g' ${TOMCAT_INST}/conf/server.xml
done
