DATE=$(date +%Y%m%d)
AREA=$1
VERSION=$2
DIR="market-server"
ansible -i /etc/ansible/hosts_$1 ~market-backend -a "s3cmd -c /home/mobileweb/admin/.s3cfg sync s3://web-version/${DATE}/${DATE}_mobogenie_${AREA}_vogamarket_${VERSION} /home/mobileweb/dyweb_tmp/"
ansible -i /etc/ansible/hosts_$1 ~market-backend -m shell -a "sh /home/mobileweb/admin/checkmd5.sh $DATE $AREA $VERSION"
read
ansible -i /etc/ansible/hosts_$1 ~market-backend -m shell -a "sh /home/mobileweb/admin/back2unzip_baseline.sh $DATE $AREA $VERSION $DIR"
ansible -i /etc/ansible/hosts_$1 ~market-backend -a "cat /home/mobileweb/project/$DIR/version.ini"

#ansible -i /etc/ansible/hosts_$1 ~market-backend -m shell -a 'sh /home/mobileweb/admin/restart_market.sh'

