#!/bin/bash
# new Env('京东评价');
# 
eval "rm -rf ./pinjia"
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

download_pinjia(){
echo "开始下载pinjia二进制文件到$PWD/pinjia目录"
curl -sS -o $PWD/pinjia/pinjia-$_ftype --create-dirs https://ghproxy.com/https://raw.githubusercontent.com/chendianwu0828/jd_pinjia/main/pinjia-$_ftype
echo "下载完成，如需重新下载或更新请先删除该文件"
if [ -f "$PWD/pinjia/pinjia-$_ftype" ]; then
    echo "$PWD/pinjia/pinjia-$_ftype"
    eval "chmod +x ./pinjia/pinjia-$_ftype"
    eval "./pinjia/pinjia-$_ftype -t pinjia"
fi
}

if [ $_ftype == "" ]; then
	echo "不支持的架构$get_arch"
else
	echo "执行$_ftype"
    if [ -f "$PWD/pinjia/pinjia-$_ftype" ]; then
        echo "$PWD/pinjia/pinjia-$_ftype"
        eval "chmod +x ./pinjia/pinjia-$_ftype"
        eval "./pinjia/pinjia-$_ftype -t pinjia"
    elif [ -f "$PWD/pinjia-$_ftype" ]; then
        echo "$PWD/pinjia-$_ftype"
        eval "chmod +x $PWD/pinjia-$_ftype"
        eval "$PWD/pinjia-$_ftype -t pinjia"
    else
        echo "在$PWD/pinjia目录、$PWD目录下均未找到文件pinjia-$_ftype，尝试拉取远程仓库文件pinjia-$_ftype"
        download_pinjia
    fi
fi
