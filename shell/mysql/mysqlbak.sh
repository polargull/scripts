#!/bin/bash - 
#===============================================================================
#
#          FILE: mysqlback.sh
# 
#         USAGE: ./mysqlback.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2016年11月16日 09:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
# cat /export/db_back/mysqlbak.sh 
#!/bin/bash -
#__author__ = 'mashata'
#__version__ = '1.0.1'

#set -x;
DATE=`date +"%Y-%m-%d"`
DATADIR="/export/db_back"

MASTERIP="10_20_28_101"
MASTERPORT="3306"

MYSQLBASE="/usr"
MYSQLUSER="root"
MYSQLPASS="1q2w3e4r"

#1:MASTER  2:SLAVE(LOCAL_HOST)
BACKUP_PLAN="1"
if [ ${BACKUP_PLAN} -eq 1 ];then
    HOST=`echo ${MASTERIP} |sed 's/_/\./g'`
    PORT=$MASTERPORT
elif [ ${BACKUP_PLAN} -eq 2 ];then
    HOST="127.0.0.1"
    PORT=$LOCALPORT
else
    echo "Rule error, please check the configuration file."
    exit 1
fi

MYSQLEXEC="${MYSQLBASE}/bin/mysql -h$HOST -u$MYSQLUSER -p$MYSQLPASS -P$PORT"
MYSQLADMINEXEC="${MYSQLBASE}/bin/mysqladmin -h$HOST -u$MYSQLUSER -p$MYSQLPASS -P$PORT"
MYSQLDUMPEXEC="${MYSQLBASE}/bin/mysqldump -h$HOST -u$MYSQLUSER -p$MYSQLPASS -P$PORT"

BACKUPDIR="${DATADIR}/${MASTERIP}/${MASTERPORT}/${DATE}"

if [ ! -d ${BACKUPDIR} ];then
    mkdir -p ${BACKUPDIR}
fi
cd ${BACKUPDIR}

db_backup_master(){
    echo -ne "=== `date "+%Y-%m-%d %H:%M:%S"` === One ===\n" > master.info
    DBLIST=`${MYSQLEXEC} -ss -e 'show databases;' |egrep -v "performance_schema|information_schema"`
    for db in ${DBLIST}
    do
        ${MYSQLDUMPEXEC} --opt ${db} > ${BACKUPDIR}/${db}.sql && gzip -9 -f ${BACKUPDIR}/${db}.sql
    done
    echo -ne "\n=== `date "+%Y-%m-%d %H:%M:%S"` === Two ===\n" >> master.info
}

back_file() {
    cd //var/atlassian/application-data/confluence/
    file_back="/var/atlassian/application-data/confluence/attachments"
    /bin/tar -zcvf ${DATE}_attachments.tgz  attachments
    mv ${DATE}_attachments.tgz ${DATADIR}/${MASTERIP}
}

rsync(){
    /usr/bin/rsync -vzrtopg --progress ${DATADIR}/${MASTERIP} 10.15.201.233::xcar_storage_backup/

}

clean(){
    #DEL_DATE=`date +"%Y-%m-%d" --date '1 month ago'`
    DEL_DATE=`date +"%Y-%m-%d" --date '10 day ago'`
    RMDIR="${DATADIR}/${MASTERIP}/${MASTERPORT}/${DEL_DATE}"
    if [ -d ${RMDIR} ];then
        rm -rf ${RMDIR}
    fi
}

case $BACKUP_PLAN in
    1) db_backup_master && back_file && clean && rsync;;
*) echo "error" && exit 1 ;;
esac
