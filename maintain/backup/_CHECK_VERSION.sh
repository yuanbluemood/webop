#!/bin/bash
## "[Usage]: sh checkALLmd5.sh 'global vn id th' server

function blue {
	echo -e "\033[36m$1\033[0m"
}
function yellow {
	echo -e "\033[33m$1\033[0m"
}

[[ $# -ne 2 ]]&&blue "[Usage]: sh _CHECK_VERSION.sh 'global br id th vn in me ru na hk' server" &&exit 1
SITE=$1
project=$2

for site in $SITE ;do
{
		blue "##############	$site 	###############"
		case $site in
                        global|id|in|th|vn|in|center)
				[ $project=='market-backend' ]&&/usr/local/ansible/bin/ansible ~market-backend -m shell -a 'cat /home/mobileweb/project/market-server/version.ini&&netstat -ntl|grep 8082' 2>/dev/null;
				[ $project=='market-frontend' ]&&/usr/local/ansible/bin/ansible ~market-helper -m shell -a 'cat /home/mobileweb/project/market/version.ini&&netstat -ntl|grep 8082' 2>/dev/null;
                        ;;
                        br)
                                blue Brazil:
                                RCCSIP=54.207.19.237
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-backend -m shell -a 'cat /home/mobileweb/project/market-server/version.ini&&netstat -ntl|grep 8082' 2>/dev/null";
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-helper -m shell -a 'cat /home/mobileweb/project/market/version.ini&&netstat -ntl|grep 8082' 2>/dev/null"
                        ;;
                        kr|hk)
                                blue Japan:
                                RCCSIP=54.199.176.122
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-backend -m shell -a 'cat /home/mobileweb/project/market-server/version.ini&&netstat -ntl|grep 8082' 2>/dev/null";
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-helper -m shell -a 'cat /home/mobileweb/project/market/version.ini&&netstat -ntl|grep 8082' 2>/dev/null"
                        ;;
                        me|ru)
                                blue Ireland:
                                RCCSIP=54.194.203.3
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-backend -m shell -a 'cat /home/mobileweb/project/market-server/version.ini&&netstat -ntl|grep 8082' 2>/dev/null";
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-helper -m shell -a 'cat /home/mobileweb/project/market/version.ini&&netstat -ntl|grep 8082' 2>/dev/null"
                        ;;
			na)
                        	blue NorthAmerica:
				RCCSIP=54.183.8.55
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-backend -m shell -a 'cat /home/mobileweb/project/market-server/version.ini&&netstat -ntl|grep 8082' 2>/dev/null";
				[ $project=='market-backend' ]&&ssh $RCCSIP "/usr/local/ansible/bin/ansible ~market-helper -m shell -a 'cat /home/mobileweb/project/market/version.ini&&netstat -ntl|grep 8082' 2>/dev/null"
			;;
                        *)
                                yellow "Error,no such site"
                                exit
                        ;;
                esac
}
done
wait
blue checkover
