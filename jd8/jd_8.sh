#!/bin/bash
# new Env('京东登录有礼红包');
# 
eval "rm -rf ./jd_8"
_ftype=""
get_arch=`arch`
echo $get_arch
if [[ $get_arch =~ "x86_64" ]];then
	_ftype="amd64"
elif [[ $get_arch =~ "x86" ]];then
	_ftype="386"
elif [[ $get_arch =~ "i386" ]];then
	_ftype="386"
elif [[ $get_arch =~ "aarch64" ]];then
	_ftype="arm64"
elif [[ $get_arch =~ "arm" ]];then
	_ftype="arm"
else
	_ftype=""
fi

download_jd_8(){
echo "开始下载jd_8二进制文件到$PWD/jd_8目录"
curl -sS -o $PWD/jd_8/jd_8-$_ftype --create-dirs https://ghproxy.com/https://raw.githubusercontent.com/chendianwu0828/jd_pinjia/main/jd8/jd_8-$_ftype
echo "下载完成，如需重新下载或更新请先删除该文件"
if [ -f "$PWD/jd_8/jd_8-$_ftype" ]; then
    echo "$PWD/jd_8/jd_8-$_ftype"
    eval "chmod +x ./jd_8/jd_8-$_ftype"
    eval "./jd_8/jd_8-$_ftype -t jd_8"
fi
}

if [ $_ftype == "" ]; then
	echo "不支持的架构$get_arch"
else
	echo "执行$_ftype"
    if [ -f "$PWD/jd_8/jd_8-$_ftype" ]; then
        echo "$PWD/jd_8/jd_8-$_ftype"
        eval "chmod +x ./jd_8/jd_8-$_ftype"
        eval "./jd_8/jd_8-$_ftype -t jd_8"
    elif [ -f "$PWD/jd_8-$_ftype" ]; then
        echo "$PWD/jd_8-$_ftype"
        eval "chmod +x $PWD/jd_8-$_ftype"
        eval "$PWD/jd_8-$_ftype -t jd_8"
    else
        echo "在$PWD/jd_8目录、$PWD目录下均未找到文件jd_8-$_ftype，尝试拉取远程仓库文件jd_8-$_ftype"
        download_jd_8
    fi
fi