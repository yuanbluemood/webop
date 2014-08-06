DATE=$1
REGION=$2
##@@how to support multi_areas
AREA=$3
PROJECT=$4
VERSION=$5
PKG=${DATE}_${REGION}_${AREA}_${PROJECT}_${VERSION}
md5sum /home/mobileweb/dyweb_tmp/${PKG}/${PKG}.zip;
cat /home/mobileweb/dyweb_tmp/${PKG}/*.md5;
