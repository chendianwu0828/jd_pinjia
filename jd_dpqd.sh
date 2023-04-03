#!/bin/bash
# new Env('京东店铺签到');
# 
eval "rm -rf ./jd_dpqd"
_ftype=""
get_arch=`arch`
echo $get_arch
if [[ $get_arch =~ "x86_64" ]];then
	_ftype="amd64"
elif [[ $get_arch =~ "x86" ]];then
	_ftype="386"
elif [[ $get_arch =~ "i386" ]];then
	_ftype="386"
else
	_ftype=""
fi

download_jd_8(){
echo "开始下载jd_dpqd二进制文件到$PWD/jd_dpqd目录"
curl -sS -o $PWD/jd_dpqd --create-dirs https://ghproxy.com/https://github.com/chendianwu0828/jd_pinjia/releases/download/1.0/jd_dpqd
echo "下载完成，如需重新下载或更新请先删除该文件"
if [ -f "$PWD/jd_dpqd" ]; then
    echo "$PWD/jd_dpqd"
    eval "chmod +x ./jd_dpqd"
    eval "./jd_dpqd"
fi
}

if [ $_ftype == "" ]; then
	echo "不支持的架构$get_arch"
else
	echo "执行$_ftype"
    if [ -f "$PWD/jd_dpqd" ]; then
        echo "$PWD/jd_dpqd"
        eval "chmod +x ./jd_dpqd"
        eval "./jd_dpqd"
    else
        echo "在$PWD目录下均未找到文件jd_dpqd，尝试拉取远程仓库文件jd_dpqd"
        download_jd_8
    fi
fi
