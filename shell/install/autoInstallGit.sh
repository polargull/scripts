#!/bin/bash - 
#===============================================================================
#
#          FILE: autoInstallGit.sh
# 
#         USAGE: ./autoInstallGit.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2016年11月01日 05:40
#      REVISION:  ---
#===============================================================================
. ./constant
GIT_LOCAL=${LOCAL_HOME}/${GIT}
conf_env () {
    sed -i '/export JAVA_HOME=/i\export GIT_HOME='${LN_HOME}'/git' ${USER_ENV}
	sed -i 's/export PATH=/&$GIT_HOME\/bin:/' ${USER_ENV}
	source ${USER_ENV}
}
install_depenc ()
{
    yum -y install curl-devel expat-develgettext-developenssl-develzlib-develgccperl-ExtUtils-MakeMaker
    yum -y install zlib-devel
    yum -y install openssl-devel
    yum -y install expat-devel.x86_64
}	# ----------  end of function install_depenc  ----------
install_git ()
{
    unzip v2.8.3.zip
    cd git-2.8.3
    make prefix=${GIT_LOCAL} all
    make prefix=${GIT_LOCAL} install
    ln -s ${GIT_LOCAL} ${LN_HOME}/git
}	# ----------  end of function install_git  ----------

# install_depenc
# install_git
# install_git
conf_env
