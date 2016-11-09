#!/bin/bash
. ~/dl/constant
sed -i '/<Connector port="8080"/a\\t\tURIEncoding="UTF-8"' ${LN_HOME}/tomcat/conf/server.xml
sed -i '/<\/tomcat-users>/i\<role rolename="admin"/>\n<user username="admin" password="admin" roles="manager-gui"/>' ${LN_HOME}/tomcat/conf/tomcat-users.xml
