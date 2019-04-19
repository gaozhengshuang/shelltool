#!/usr/bin/env python
#coding=utf-8

import os
import sys
import string
import types
import requests
import time
import traceback
import subprocess

month=""
day=""
hour=""
minute=""
week="*"

directory="/home/xiyou/pythontester/bin"
script="crontabctl.py"
settime="02-25-20-30"


# 解析输入参数
if len(sys.argv) < 4:
    print "参数数量不足，示例: crontabctl.py 02-25-20-30 /home/xiyou2/platform-version/20190305R1_PP/release runplatform.sh"
    print "参数数量不足，示例: crontabctl.py 02-25-20-30 /home/xiyou2/version/20190305R1_PP/release/server runplatform.sh start"
    print "参数数量不足，示例: crontabctl.py 02-25-20-30 /home/xiyou2/version/20190305R1_PP/release/server runserver.sh start s1 s2"
    exit()

settime = sys.argv[1]
directory = sys.argv[2]
script = sys.argv[3]
param1 = ""
param2 = ""
if len(sys.argv) >= 5:
    param1 = sys.argv[4]

if len(sys.argv) >= 6:
    param2 = sys.argv[5]

sptime = settime.split("-", -1)
len(sptime)
if len(sptime) != 4:
    print("时间参数错误格式错误，示例：02-25-20-30")
    exit()

month, day, hour, minute = sptime[0], sptime[1], sptime[2], sptime[3]
print month, day, hour, minute


## 生成唯一id
nowtime = subprocess.check_output("date +%Y%m%d-%H%M%S%N", shell=True)
nowtime = nowtime.replace("\n","")
version = "UUID-" + nowtime
dirname = "~/crontask/TASK-{}".format(nowtime)
taskname = "~/crontask/TASK-{}/oldtask".format(nowtime)


## 检查文件是否存在
try:
    filecheck = directory + "/" + script
    fd = open(filecheck, "r+")
except IOError:
    print "文件不存在: ", filecheck
else:
    fd.close()

cmdexec = "{} {} {} {} * cd {} && source ~/.bashrc &&./{} {} {} && echo {}".format(minute, hour, day, month, directory, script, param1, param2, version)
#print cmdexec


## 添加任务
subprocess.check_output("mkdir -p {}".format(dirname), shell=True)
subprocess.call("crontab -l > {}".format(taskname), shell=True)
subprocess.check_output("echo '{}' >> {}".format(cmdexec, taskname), shell=True)
subprocess.check_output("crontab {}".format(taskname), shell=True)


## 删除任务
#rmtask = "{} {} {} {} * cd {} && crontab -l > tmpfile && sed -i '/{}/d' tmpfile && crontab tmpfile".format(minute, hour, day, month, dirname, version)
#subprocess.check_output("echo '{}' >> {}".format(rmtask, taskname), shell=True)
#subprocess.check_output("crontab {}".format(taskname), shell=True)

##
print subprocess.check_output("crontab -l", shell=True)

## crontab -l
#raw 00 16 23 2 * cd /home/guaji5/version/20190223R1_PP/release && ./RunServer.sh

## example



