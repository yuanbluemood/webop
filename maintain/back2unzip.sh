#!/bin/bash
DATE=$1
REGION=$2
##@@how to support multi_areas
AREA=$3
PROJECT=$4
VERSION=$5
DIR=$6
UPTYPE=$7
PKG=${DATE}_${REGION}_${AREA}_${PROJECT}_${VERSION}

[[ $# -ne 7 ]]&&echo "Args wrong,must have 7 args:DATE,REGION,AREA,PROJECT,VERSION,DIR,UPTYPE"&&exit 1
if [ ! -d /home/mobileweb/project/${DIR} ];then echo no such dir:${DIR};exit 1;fi
if [ ! -d $PKG ];then echo no such pkg:$PKG on server ;exit 1;fi
##backup
oldversion=`cat /home/mobileweb/project/${DIR}/version.ini|awk -F"_" '{print $NF}'`;
cd /home/mobileweb/project/ && cp -r ${DIR} ${DIR}-${DATE}-${oldversion};
ls /home/mobileweb/project/${DIR} /home/mobileweb/project/${DIR}-${DATE}-${oldversion} -lrth;


##unzip
cd /home/mobileweb/project/${DIR}/;
[ $UPTYPE == 'baseline' ]&&rm -rf /home/mobileweb/project/${DIR}/* ;
unzip -o /home/mobileweb/dyweb_tmp/${PKG}/${PKG}.zip -d /home/mobileweb/project/${DIR}/ >/dev/null
