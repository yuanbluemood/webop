#!/bin/bash
##20140728_mobogenie_gl_vogaserver_55040-->20140728_voga_gl_server_55040
##20140728_mobogenie_gl_vogaserver_55040-->$DATE_$REGION_$AREA_$PROJECT_$VERSION
##$DATE_$REGION_$AREA_$PROJECT_$VERSION
##@sh _common.sh mobogenie gl socialcms 56519 social-cms baseline
##@20140731_mobogenie_gl_socialcms_56519

DATE=$( TZ='Asia/Shanghai' date +%Y%m%d)

#REGION="mobo|voga"
#AREA="gl|in|id|vn|th|br|me|ru|na|hk"
#PROJECT="public|..."
#VERSION="54321"
#DIR="public|..."
#UPTYPE="update|baseline"

REGION=$1
##@@how to support multi_areas
AREA=$2
PROJECT=$3
VERSION=$4
DIR=$5
UPTYPE=$6

##like:20140731_voga_gl_market-frontend_25555
PKG=${DATE}_${REGION}_${AREA}_${PROJECT}_${VERSION}
s3cmd -c /home/maintain/.s3cfg ls s3://web-version/${DATE}/${PKG}/
read

##download pakage
ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -a "s3cmd -c /home/mobileweb/admin/.s3cfg sync s3://web-version/${DATE}/${PKG} /home/mobileweb/dyweb_tmp/"
ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -m shell -a "sh /home/mobileweb/admin/checkmd5.sh $DATE $REGION $AREA $PROJECT $VERSION"
echo 'download over'
read

##backup and unzip
ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -m shell -a "sh /home/mobileweb/admin/back2unzip.sh $DATE $REGION $AREA $PROJECT $VERSION $DIR $UPTYPE"
ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -a "cat /home/mobileweb/project/$DIR/version.ini"
echo 'backup and unzip over'
read

##restart
echo "please run as root: ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -m shell -a 'su - mobileweb -c \"sh /home/mobileweb/admin/restart_market.sh\"'"
##sudo ansible -i /etc/ansible/hosts_$AREA ~$PROJECT -m shell -a 'su - mobileweb -c "sh /home/mobileweb/admin/restart_market.sh"'
