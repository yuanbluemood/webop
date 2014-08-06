##20140728_mobogenie_gl_vogaserver_55040-->20140728_voga_gl_server_55040
##20140728_mobogenie_gl_vogaserver_55040-->$DATE_$REGION_$AREA_$PROJECT_$VERSION
##$DATE_$REGION_$AREA_$PROJECT_$VERSION

DATE=$(date +%Y%m%d)
REGION="mobo|voga"
AREA="gl|in|id|vn|th|br|me|ru|na|hk"
PROJECT="public|........."
VERSION="54321"

DIR="public"
UPTYPE="update|baseline"

PKG=${DATE}_${REGION}_${AREA}_${PROJECT}_${VERSION}
echo $PKG
ansible ~$PROJECT -a "s3cmd -c /home/mobileweb/admin/.s3cfg sync s3://web-version/${DATE}/${PKG} /home/mobileweb/dyweb_tmp/"
ansible ~$PROJECT -m shell -a "sh /home/mobileweb/admin/checkmd5.sh $DATE $AREA $VERSION $PROJECT"
[ $UPTYPE == 'update' ]&&ansible ~$PROJECT -m shell -a "sh /home/mobileweb/admin/back2unzip_update.sh $DATE $AREA $VERSION $DIR $PROJECT"
[ $UPTYPE == 'baseline' ]&&ansible ~$PROJECT -m shell -a "sh /home/mobileweb/admin/back2unzip_baseline.sh $DATE $AREA $VERSION $DIR $PROJECT"
ansible ~$PROJECT -a "cat /home/mobileweb/project/$DIR/version.ini"

#ansible ~$PROJECT -m shell -a 'sh /home/mobileweb/admin/restart_market.sh'
