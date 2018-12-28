#!/bin/bash

param_grep=$2
if [ -z $2 ]  #如果参数是空
then
  param_grep="-w"
elif [ "-i" == "$2" ] 
then
  param_grep="-i"
else
  param_grep="$2"   #例如: fs 'string' -w -i
fi


# 默认在指定文件类型中查找，否则所有文件
param_find_all_file=$3
if [ -z $3 ]
then
    find ./ -iname \*.[ch] -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.cc  -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.cpp -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.lua -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.xml -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.proto -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.go  -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.json -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.py -exec grep $param_grep -n --color -H "$1" \{\} \;
    find ./ -iname \*.sql -exec grep $param_grep -n --color -H "$1" \{\} \;
elif [ "all" == $3 ]
then
    find ./ -type f | xargs grep $param_grep -n --color -H "$1"
fi
