#!/bin/bash
DATE=$1
OLDVERSION=$2
DIR=$3
[[ $# -ne 3 ]]&&echo "Args wrong,must have 3 args:DATE,OLDVERSION,DIR"&&exit 1
if [ ! -d /home/mobileweb/project/${DIR} ];then echo no such dir:${DIR};exit 1;fi
if [ ! -d /home/mobileweb/project/${DIR}-${DATE}-${OLDVERSION} ];then echo no such backup dir:${DIR}-${DATE}-${OLDVERSION};exit 1;fi
##backup
failversion=`cat /home/mobileweb/project/${DIR}/version.ini|awk -F"_" '{print $NF}'`;
cd /home/mobileweb/project/ && mv ${DIR} ${DIR}-${DATE}Failed-${failversion}&&mv ${DIR}-${DATE}-${OLDVERSION} ${DIR};
ls /home/mobileweb/project/${DIR} /home/mobileweb/project/${DIR}-${DATE}Failed-${failversion} -lrth;
echo rollback to $OLDVERSION;
