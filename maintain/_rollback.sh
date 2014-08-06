#!/bin/bash
[[ $# -ne 4 ]]&&echo "[Usage]: sh _rollback br market-backend 56326(!oldversion) market-server" &&exit 1
DATE=$( TZ='Asia/Shanghai' date +%Y%m%d)

#AREA="gl|in|id|vn|th|br|me|ru|na|hk"
#PROJECT="public|..."
#VERSION="54321"
#DIR="public|..."

AREA=$1
PROJECT=$2
OLDVERSION=$3
DIR=$4
ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -m copy -a "src=/home/maintain/rollback.sh dest=/home/mobileweb/admin/rollback.sh owner=mobileweb group=mobileweb mode=0755"

ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -m shell -a "sh /home/mobileweb/admin/rollback.sh $DATE $OLDVERSION $DIR"
ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -a "cat /home/mobileweb/project/$DIR/version.ini"
