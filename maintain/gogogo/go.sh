#!/bin/bash
function blue {
        echo -e "\033[36m$1\033[0m"
}
function yellow {
        echo -e "\033[33m$1\033[0m"
}

DATE=$( TZ='Asia/Shanghai' date +%Y%m%d)

#REGION="mobo|voga"
#AREA="gl|in|id|vn|th|br|me|ru|na|hk"
#PROJECT="public|..."
#VERSION="54321"
#DIR="public|..."
#UPTYPE="update|baseline"

REGION=$1
SITE=$2
PROJECT=$3
VERSION=$4
DIR=$5
UPTYPE=$6

function verify_allargs {
	##verify
	echo
}

Singapore="SingaporeNULL;"
SaoPaulo="SaoPauloNULL;"
Tokyo="TokyoNULL;"
Ireland="IrelandNULL;"
California="CaliforniaNULL;"

for country in $SITE;do
	case $country in 
                gl|id|in|th|vn|center)
			Singapore="$Singapore$country*$PROJECT*;"
                ;;
                br)
                        #blue Brazil:
                        SaoPauloCCS=54.207.19.237
			SaoPaulo="$SaoPaulo$country*$PROJECT*;"
                ;;
                kr|hk)
                        #blue Japan:
                        TokyoCCS=54.199.176.122
			Tokyo="$Tokyo$country*$PROJECT*;"
                ;;
                me|ru)
                        #blue Egypt/MidEast:
                        IrelandCCS=54.194.203.3
			Ireland="$Ireland$country*$PROJECT*;"
                ;;
                na)
                        #blue NorthAmerica:
                        CaliforniaCCS=54.183.8.55
			California="$California$country*$PROJECT*;"
                ;;
                *)
                        yellow "Error,no such site"
                        exit
                ;;
        esac


done

Singapore="'$Singapore'"
SaoPaulo="'$SaoPaulo'"
Tokyo="'$Tokyo'"
Ireland="'$Ireland'"
California="'$California'"



[ $Singapore == "'SingaporeNULL;'" ]||ansible $Singapore --list-host;
[ $SaoPaulo == "'SaoPauloNULL;'" ]||ssh $SaoPauloCCS "ansible $SaoPaulo --list-host;"
[ $Tokyo == "'TokyoNULL;'" ]||ssh $TokyoCCS "ansible $Tokyo --list-host;"
[ $Ireland == "'IrelandNULL;'" ]||ssh $IrelandCCS "ansible $Ireland --list-host;"
[ $California == "'CaliforniaNULL;'" ]||ssh $CaliforniaCCS "ansible $California --list-host;"
