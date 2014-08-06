DATE=$(date +%Y%m%d)
AREA=$1
VERSION=$2
DIR="public"
PROJECT="public"
UPTYPE=$3

ansible ~$PROJECT -a "s3cmd -c /home/mobileweb/admin/.s3cfg sync s3://web-version/${DATE}/${DATE}_mobogenie_${AREA}_mobo${PROJECT}_${VERSION} /home/mobileweb/dyweb_tmp/"
ansible ~$PROJECT -m shell -a "sh /home/mobileweb/admin/checkmd5.sh $DATE $AREA $VERSION $PROJECT"
[ $UPTYPE == 'update' ]&&ansible ~$PROJECT -m shell -a "sh /home/mobileweb/admin/back2unzip_update.sh $DATE $AREA $VERSION $DIR $PROJECT"
[ $UPTYPE == 'baseline' ]&&ansible ~$PROJECT -m shell -a "sh /home/mobileweb/admin/back2unzip_baseline.sh $DATE $AREA $VERSION $DIR $PROJECT"
ansible ~$PROJECT -a "cat /home/mobileweb/project/$DIR/version.ini"

#ansible ~$PROJECT -m shell -a 'sh /home/mobileweb/admin/restart_market.sh'
