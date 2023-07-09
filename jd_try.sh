#!/bin/bash
# new Env('京东试用申请');
# 
eval "rm -rf ./jd_try"
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

download_jd_try(){
echo "开始下载jd_try二进制文件到$PWD/jd_try目录"
curl -sS -o $PWD/jd_try/try-$_ftype --create-dirs https://ghproxy.com/https://raw.githubusercontent.com/chendianwu0828/jd_pinjia/main/try/try-$_ftype
echo "下载完成，如需重新下载或更新请先删除该文件"
if [ -f "$PWD/jd_try/try-$_ftype" ]; then
    echo "$PWD/jd_try/try-$_ftype"
    eval "chmod +x ./jd_try/try-$_ftype"
    eval "./jd_try/try-$_ftype -t pinjia"
fi
}

if [ $_ftype == "" ]; then
	echo "不支持的架构$get_arch"
else
	echo "执行$_ftype"
    if [ -f "$PWD/jd_try/try-$_ftype" ]; then
        echo "$PWD/jd_try/try-$_ftype"
        eval "chmod +x ./jd_try/try-$_ftype"
        eval "./jd_try/try-$_ftype -t pinjia"
    elif [ -f "$PWD/try-$_ftype" ]; then
        echo "$PWD/try-$_ftype"
        eval "chmod +x $PWD/try-$_ftype"
        eval "$PWD/try-$_ftype -t pinjia"
    else
        echo "在$PWD/try目录、$PWD目录下均未找到文件try-$_ftype，尝试拉取远程仓库文件try-$_ftype"
        download_jd_try
    fi
fi