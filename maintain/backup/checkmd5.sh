if [ -d /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_vogamarket_${3} ];then
	md5sum /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_vogamarket_${3}/${1}_mobogenie_${2}_vogamarket_${3}.zip;
	cat /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_vogamarket_${3}/md5sum.md5;
elif [ -d /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_marketfrontend_${3} ];then
	md5sum /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_marketfrontend_${3}/${1}_mobogenie_${2}_marketfrontend_${3}.zip;
	cat /home/mobileweb/dyweb_tmp/${1}_mobogenie_${2}_marketfrontend_${3}/md5sum.md5;
else 
	echo no pkg file;
fi
