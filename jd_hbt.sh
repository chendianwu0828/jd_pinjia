#!/bin/bash
# new Env('京东微信红包团');
#  
eval "rm -rf ./jd_hbt"
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

download_jd_hbt(){
echo "开始下载jd_hbt二进制文件到$PWD/jd_hbt目录"
curl -sS -o $PWD/jd_hbt/jd_hbt-$_ftype --create-dirs https://ghproxy.com/https://raw.githubusercontent.com/chendianwu0828/jd_pinjia/main/hbt/jd_hbt-$_ftype
echo "下载完成，如需重新下载或更新请先删除该文件"
if [ -f "$PWD/jd_hbt/jd_hbt-$_ftype" ]; then
    echo "$PWD/jd_hbt/jd_hbt-$_ftype"
    eval "chmod +x ./jd_hbt/jd_hbt-$_ftype"
    eval "./jd_hbt/jd_hbt-$_ftype -t jd_hbt"
fi
}

if [ $_ftype == "" ]; then
	echo "不支持的架构$get_arch"
else
	echo "执行$_ftype"
    if [ -f "$PWD/jd_hbt/jd_hbt-$_ftype" ]; then
        echo "$PWD/jd_hbt/jd_hbt-$_ftype"
        eval "chmod +x ./jd_hbt/jd_hbt-$_ftype"
        eval "./jd_hbt/jd_hbt-$_ftype -t jd_hbt"
    elif [ -f "$PWD/jd_hbt-$_ftype" ]; then
        echo "$PWD/jd_hbt-$_ftype"
        eval "chmod +x $PWD/jd_hbt-$_ftype"
        eval "$PWD/jd_hbt-$_ftype -t jd_hbt"
    else
        echo "在$PWD/jd_hbt目录、$PWD目录下均未找到文件jd_hbt-$_ftype，尝试拉取远程仓库文件jd_hbt-$_ftype"
        download_jd_hbt
    fi
fi
