#!/bin/bash - 
#===============================================================================
#
#          FILE: reset.sh
# 
#         USAGE: ./reset.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2016年11月05日 11:10
#      REVISION:  ---
#===============================================================================

. ~/dl/constant
set -o nounset                              # Treat unset variables as an error
#构建工程名称
PROJECT_NAME=webapp1
DEPLOY_HOME=$SITE_DEV/$PROJECT_NAME
#目标IP
# IP=(10.10.*.85 10.10.*.41)
#远程部署
# echo $DEPLOY_HOME/$PROJECT_NAME.version
DEPLOY_PROJECT_PATH=`tac $DEPLOY_HOME/$PROJECT_NAME.version|sed -n 2p`
echo $DEPLOY_PROJECT_PATH
rm -rf $DEPLOY_HOME/deploy
ln -s $DEPLOY_PROJECT_PATH $DEPLOY_HOME/deploy
${LN_HOME}/tomcat/inst/${PROJECT_NAME}/tomcat.sh restart
#远程部署
# DEPLOY_PROJECT_PATH=tac $DEPLOY_HOME/$PROJECT_NAME.version|sed -n 2p
# rm -rf $DEPLOY_HOME/${PROJECT_NAME}-deploy
# ln -s $DEPLOY_PROJECT_PATH $DEPLOY_HOME/${PROJECT_NAME}-deploy
# /home/www/projectName-deploy
# ssh root@${server} "/usr/local/tomcat-${PROJECT_NAME}/bin/restart.sh"
# for server in ${IP[*]};
# do
# done
