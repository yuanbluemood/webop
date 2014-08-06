DATE=$(date +%Y%m%d)
AREA=$2
VERSION=$1
DIR="market"

ansible -i /etc/ansible/hosts_$AREA ~market-helper -a "s3cmd -c /home/mobileweb/admin/.s3cfg sync s3://web-version/${DATE}/${DATE}_mobogenie_${AREA}_marketfrontend_${VERSION} /home/mobileweb/dyweb_tmp/"
ansible -i /etc/ansible/hosts_$AREA ~market-helper -m shell -a "sh /home/mobileweb/admin/checkmd5.sh $DATE $AREA $VERSION"

read
ansible -i /etc/ansible/hosts_$AREA ~market-helper -m shell -a "sh /home/mobileweb/admin/back2unzip_baseline.sh $DATE $AREA $VERSION $DIR"
ansible -i /etc/ansible/hosts_$AREA ~market-helper -a "cat /home/mobileweb/project/$DIR/version.ini"

#ansible -i /etc/ansible/hosts_$AREA ~market-helper -m shell -a 'sh /home/mobileweb/admin/restart_market.sh'
