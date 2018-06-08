#!/bin/sh
#错误立刻退出
set -e     
oldstr=$1
newstr=$2
filetype=$3

if [ -z $oldstr ]
then
    echo "参数错误"
    echo "说明：参数1：源字符串，参数2：新字符串，参数3[可选]：文件类型，默认所有类型"
    echo "范例：replace-all.sh 旧字符串 新字符串 json"
    exit
fi


if [ -z $newstr ]
then
    echo "参数错误"
    echo "说明：参数1：源字符串，参数2：新字符串，参数3[可选]：文件类型，默认所有类型"
    echo "范例：replace-all.sh 旧字符串 新字符串 json"
    exit
fi


#如果参数3空，默认所有类型
if [ -z $filetype ]
then
    find ./ -type f | xargs sed -i "s/$oldstr/$newstr/g"
    echo "替换文件[*]"
else
    find ./ -iname \*.$filetype | xargs sed -i "s/$oldstr/$newstr/g"
    echo "替换文件[*.$filetype]"
fi

#sed -i "s/$oldstr/$newstr/g" `grep "$oldstr" -rl "$workpath"`
echo "替换字符串:" $oldstr "-->" $newstr
echo "替换完成"
