#!/bin/bash
# new Env('城城分领现金');
# 
eval "rm -rf ./chengcheng"
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

download_chengcheng(){
echo "开始下载chengcheng二进制文件到$PWD/chengcheng目录"
curl -sS -o $PWD/chengcheng/chengcheng-$_ftype --create-dirs https://ghproxy.com/https://raw.githubusercontent.com/chendianwu0828/jd_pinjia/main/chengcheng/chengcheng-$_ftype
echo "下载完成，如需重新下载或更新请先删除该文件"
if [ -f "$PWD/chengcheng/chengcheng-$_ftype" ]; then
    echo "$PWD/chengcheng/chengcheng-$_ftype"
    eval "chmod +x ./chengcheng/chengcheng-$_ftype"
    eval "./chengcheng/chengcheng-$_ftype -t chengcheng"
fi
}

if [ $_ftype == "" ]; then
	echo "不支持的架构$get_arch"
else
	echo "执行$_ftype"
    if [ -f "$PWD/chengcheng/chengcheng-$_ftype" ]; then
        echo "$PWD/chengcheng/chengcheng-$_ftype"
        eval "chmod +x ./chengcheng/chengcheng-$_ftype"
        eval "./chengcheng/chengcheng-$_ftype -t chengcheng"
    elif [ -f "$PWD/chengcheng-$_ftype" ]; then
        echo "$PWD/chengcheng-$_ftype"
        eval "chmod +x $PWD/chengcheng-$_ftype"
        eval "$PWD/chengcheng-$_ftype -t chengcheng"
    else
        echo "在$PWD/chengcheng目录、$PWD目录下均未找到文件chengcheng-$_ftype，尝试拉取远程仓库文件chengcheng-$_ftype"
        download_chengcheng
    fi
fi
