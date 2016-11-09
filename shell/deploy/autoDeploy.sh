#!/bin/bash - 
#===============================================================================
#
#          FILE: autoDeploy.sh
# 
#         USAGE: ./autoDeploy.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2016年11月05日 11:44
#      REVISION:  ---
#===============================================================================
. ~/dl/constant
set -o nounset                              # Treat unset variables as an error
PROJECT_NAME=webapp1
DEPLOY_HOME=$SITE_DEV/$PROJECT_NAME
CURTIME=`date +%Y%m%d%H%M%S`
echo $CURTIME
# 定义远程新部署应用目录 DEPLOY_PROJECT_PATH=/home/www/projectName-timestamp
DEPLOY_PROJECT_PATH=$DEPLOY_HOME/$PROJECT_NAME-$CURTIME
# 远程 创建新部署的应用目录（ 删除存在的应用目录下资源）
rm -rf $DEPLOY_PROJECT_PATH/* && mkdir -p $DEPLOY_PROJECT_PATH
# 远程 拷贝应用到新应用目录
cp ~/webapp1/target/$PROJECT_NAME.war $DEPLOY_PROJECT_PATH/$PROJECT_NAME.war
# 远程 解压新应用war包并删除当前war
mkdir -p $DEPLOY_PROJECT_PATH; cd $DEPLOY_PROJECT_PATH; unzip -q $PROJECT_NAME.war && rm -f $PROJECT_NAME.war
# 远程 删除应用软链接
rm -rf $DEPLOY_HOME/deploy
# 远程 创建应用软链接 软链接 -> 用当前最新应用目录
ln -s $DEPLOY_PROJECT_PATH $DEPLOY_HOME/deploy
# 远程 重启tomcat
# ssh root@${server} "/usr/local/tomcat-$PROJECT_NAME/bin/restart.sh"
# 远程 将新目录路径写到version
echo $DEPLOY_PROJECT_PATH >> $DEPLOY_HOME/$PROJECT_NAME.version
