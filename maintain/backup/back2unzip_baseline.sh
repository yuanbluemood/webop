##backup
version=`cat /home/mobileweb/project/$4/version.ini|awk -F"_" '{print $NF}'`;
cd /home/mobileweb/project/ && cp -r $4 $4-$1-$version;
ls /home/mobileweb/project/$4 /home/mobileweb/project/$4-$1-$version -lrth;


##unzip
cd /home/mobileweb/project/$4/ && rm -rf * ;
if [ -d /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_vogamarket_${3} ];then
	unzip -o /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_vogamarket_${3}/${1}_mobogenie_${2}_vogamarket_${3}.zip -d /home/mobileweb/project/$4/ >/dev/null
elif [ -d /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_marketfrontend_${3} ];then
	unzip -o /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_marketfrontend_${3}/${1}_mobogenie_${2}_marketfrontend_${3}.zip -d /home/mobileweb/project/$4/ >/dev/null
else 
	echo no pkg file;
fi
