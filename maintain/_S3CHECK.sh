#!/bin/bash
date1=$(date +%Y%m%d)
date1=$( TZ='Asia/Shanghai' date +%Y%m%d)
cd /home/mobileweb/admin

function blue {
        echo -e "\033[36m$1\033[0m"
}
function yellow {
        echo -e "\033[33m$1\033[0m"
}

function versionfile_verify {
	blue "##############   Verify version-${date1}.info   ############"
	BASEDIR=`dirname $0`
	cat $BASEDIR/version-${date1}.info|grep -v '^#'&&source $BASEDIR/version-${date1}.info
	
	for area in $AREA;do 
		case $area in
			gl|center|id|in|th|vn|br|kr|me|ru|na|hk)
		;;
			*)
				yellow "No such site \"$area\""&&exit 1
		;;
		esac
	done
	if [ "$SITE" == "voga" ] || [ "$SITE" == "mobo" ];then :;else yellow "SITE must be voga or mobo"&&exit 1;fi
	if [ "$UPDATE" == "update" ] || [ "$UPDATE" == "baseline" ];then :;else yellow "UPDATE must be update or baseline"&&exit 1;fi
	for type in $TYPE;do
		case $type in
			server|cms|public|synch|market-backend)
		;;
			*)
				yellow "No such server type \"$type\",must be server,cms or public"&&exit 1
		;;
		esac
	done
	blue "version-${date1}.info is OK ,UPDATE start !"
}

versionfile_verify

for area in `grep AREA version-${date1}.info|grep -v '#'|sed 's/"//g'|awk -F= '{print $2}'`;do

	blue "#########################              $area              ##########################"
	case $area in 
		gl|id|in|th|vn|center)
##			cd /home/mobileweb/admin/&&sh _update $1 2 3 4 5  $area
		;;
		br)
			blue Brazil:
			RCCSIP=54.207.19.237
			scp version-${date1}.info $RCCSIP:/home/mobileweb/admin/
			ssh $RCCSIP "cd /home/mobileweb/admin&&sh op_version_update.sh $area"
		;;
		kr|hk)
			blue Japan:
			RCCSIP=54.199.176.122
			scp version-${date1}.info $RCCSIP:/home/mobileweb/admin/
			ssh $RCCSIP "cd /home/mobileweb/admin&&sh op_version_update.sh $area"
		;;
		me|ru)
			blue Egypt/MidEast:
			RCCSIP=54.194.203.3
			scp version-${date1}.info $RCCSIP:/home/mobileweb/admin/
			ssh $RCCSIP "cd /home/mobileweb/admin&&sh -x op_version_update.sh $area"
		;;
		na)
			blue NorthAmerica:
			RCCSIP=54.183.8.55
			scp version-${date1}.info $RCCSIP:/home/mobileweb/admin/
			ssh $RCCSIP "cd /home/mobileweb/admin&&sh -x op_version_update.sh $area"
		;;
		*)	
			yellow "Error,no such site"	
			exit
		;;
	esac

done
cp version-${date1}.info version_dir/version-${date1}.info.old`date +%H%M`
mv version-${date1}.info{,2}
