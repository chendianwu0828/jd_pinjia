#!/bin/bash
# new Env('京东极速版-赚钱大赢家');
# 
eval "rm -rf ./jd_dyj"
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

download_jd_dyj(){
echo "开始下载jd_dyj二进制文件到$PWD/jd_dyj目录"
curl -sS -o $PWD/jd_dyj/jd_dyj-$_ftype --create-dirs https://ghproxy.com/https://raw.githubusercontent.com/chendianwu0828/jd_pinjia/main/dyj/jd_dyj-$_ftype
echo "下载完成，如需重新下载或更新请先删除该文件"
if [ -f "$PWD/jd_dyj/jd_dyj-$_ftype" ]; then
    echo "$PWD/jd_dyj/jd_dyj-$_ftype"
    eval "chmod +x ./jd_dyj/jd_dyj-$_ftype"
    eval "./jd_dyj/jd_dyj-$_ftype -t jd_dyj"
fi
}

if [ $_ftype == "" ]; then
	echo "不支持的架构$get_arch"
else
	echo "执行$_ftype"
    if [ -f "$PWD/jd_dyj/jd_dyj-$_ftype" ]; then
        echo "$PWD/jd_dyj/jd_dyj-$_ftype"
        eval "chmod +x ./jd_dyj/jd_dyj-$_ftype"
        eval "./jd_dyj/jd_dyj-$_ftype -t jd_dyj"
    elif [ -f "$PWD/jd_dyj-$_ftype" ]; then
        echo "$PWD/jd_dyj-$_ftype"
        eval "chmod +x $PWD/jd_dyj-$_ftype"
        eval "$PWD/jd_dyj-$_ftype -t jd_dyj"
    else
        echo "在$PWD/jd_dyj目录、$PWD目录下均未找到文件jd_dyj-$_ftype，尝试拉取远程仓库文件jd_dyj-$_ftype"
        download_jd_dyj
    fi
fi
