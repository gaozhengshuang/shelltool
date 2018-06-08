#!/usr/bin/env python
#coding=utf-8

import os
import sys
import string
import types
import requests
import time


def GetOnlineUserAmount():
    print "获取在线人数"
    print "redis-cli scard gate_accounts_210.73.214.75:8010 " + os.popen("redis-cli scard gate_accounts_210.73.214.75:8010", 'r').read(),
    print "redis-cli scard gate_accounts_210.73.214.76:8011 " + os.popen("redis-cli scard gate_accounts_210.73.214.76:8011", 'r').read(),
    print "redis-cli scard gate_accounts_210.73.214.76:8012 " + os.popen("redis-cli scard gate_accounts_210.73.214.76:8012", 'r').read(),
    print "redis-cli scard gate_accounts_210.73.214.76:8013 " + os.popen("redis-cli scard gate_accounts_210.73.214.76:8013", 'r').read(),


def GetRoomAmount():
    print "获取房间数量"
    print "redis-cli scard RS_RoomServer000_RoomSize " + os.popen("redis-cli scard RS_RoomServer000_RoomSize",'r').read(),
    print "redis-cli scard RS_RoomServer001_RoomSize " + os.popen("redis-cli scard RS_RoomServer001_RoomSize",'r').read(),
    print "redis-cli scard RS_RoomServer002_RoomSize " + os.popen("redis-cli scard RS_RoomServer002_RoomSize",'r').read(),
    print "redis-cli scard RS_RoomServer003_RoomSize " + os.popen("redis-cli scard RS_RoomServer003_RoomSize",'r').read()



coin1consume , coin3consume = "", ""
def GetCoinConsume():
    print "=========金币消耗========="
    global coin1consume, coin3consume
    coin1consume = os.popen("grep '扣除金币\[1000\]' ~/log/daemon.roomserver.2018-05-25* | grep -v '2018-05-25-17' -c", 'r').read()
    coin3consume = os.popen("grep '扣除金币\[3000\]' ~/log/daemon.roomserver.2018-05-25* | grep -v '2018-05-25-17' -c", 'r').read()
    print "普通场:", string.atol(coin1consume), "次"
    print "钻市场:", string.atol(coin3consume), "次"
    print "合计消耗:", string.atol(coin1consume)*1000 + string.atol(coin3consume)*3000, "金币"


outdiamond, outdiamondpart = "", ""
def GetDiamondAndPartsOutput():
    print "======钻石和碎片产出======"
    global outdiamond, outdiamondpart
    outdiamond = os.popen("grep '游戏拾取' ~/log/daemon.roomserver.2018-05-25* | grep '添加道具\[10001\]' -c", 'r').read()
    outdiamondpart = os.popen("grep '游戏拾取' ~/log/daemon.roomserver.2018-05-25* | grep '添加道具\[10002\]' -c", 'r').read()
    print "钻石产出:", string.atol(outdiamond), "碎片产出:", string.atol(outdiamondpart)
    print "合计产出:", string.atof(outdiamond) + string.atof(outdiamondpart)/10
    rebate = 100 * (string.atof(outdiamond)*12000 + string.atof(outdiamondpart)*1200) / (string.atof(coin1consume)*1000 + string.atof(coin3consume)*3000)
    print ("返利比: %.2f%%" % rebate)


def GetExchangeAmount():
    print "=========兑换钻石========="
    os.popen("grep '扣除道具\[10001\]' ~/log/daemon.gateserver.2018-05-25* > ~/diamond.txt", 'r').read()
    os.popen("grep '扣除道具\[10002\]' ~/log/daemon.gateserver.2018-05-25* > ~/diamondparts.txt", 'r').read()

    exchangediamond = os.popen("cat ~/diamond.txt", 'r').read()
    listexchangediamond = exchangediamond.splitlines()
    amountdiamond = 0
    for info in listexchangediamond:
        amountstr = info.split(' ')[6]
        amountdiamond += string.atol(amountstr[7:len(amountstr)-1])
    print "兑换钻石:", amountdiamond

    exchangeparts = os.popen("cat ~/diamondparts.txt", 'r').read()
    listexchangeparts = exchangeparts.splitlines()
    amountparts = 0
    for info in listexchangeparts:
        amountstr = info.split(' ')[6]
        amountparts += string.atol(amountstr[7:len(amountstr)-1])
    print "兑换碎片:", amountparts


def GetJumpLoginStat(datestart):
    print "========登陆数据========="
    url = "http://210.73.214.75:19000"
    body = '''{"gmcmd":"login", "date":"%s", "day":"15"}''' % datestart
    print requests.post(url, body)

    cmd = "grep 登陆统计 ~/log/daemon.matchserver.2018-05-25-18-26-47.log | grep 日期:%s" % time.strftime("%Y-%m-%d", time.localtime())
    loginstat = os.popen(cmd, 'r').read()
    listloginstat = loginstat.splitlines()
    logintxt = listloginstat[len(listloginstat)-1]
    print logintxt


def CalcJumpDiamondRebate():
    print "=======钻石场计算======="
    print "12000价值:", string.atol(outdiamond) * 12000 + string.atol(outdiamondpart) * 1200
    print "10000价值:", string.atol(outdiamond) * 10000 + string.atol(outdiamondpart) * 1000
    print "12000返利比:", (string.atof(outdiamond)*12000 + string.atof(outdiamondpart)*1200) / (string.atof(coin1consume)*1000 + string.atof(coin3consume)*3000)
    print "10000返利比:", (string.atof(outdiamond)*10000 + string.atof(outdiamondpart)*1000) / (string.atof(coin1consume)*1000 + string.atof(coin3consume)*3000)


def RunFunc(cmd, *argu):
    switcher = {
            "online" : GetOnlineUserAmount,
            "room" : GetRoomAmount,
            "consume" : GetCoinConsume,
            "diamondoutput" : GetDiamondAndPartsOutput,
            "rebate": CalcJumpDiamondRebate,
            "exchange" : GetExchangeAmount,
            "login" : GetJumpLoginStat,
            }
    f = switcher.get(cmd)
    if f == None: print "无效的cmd指令"; return
    if len(argu) == 0: 
        f()
    else:
        f(argu[0])

RunFunc("online")
RunFunc("room")
RunFunc("consume")
RunFunc("diamondoutput")
RunFunc("exchange")
RunFunc("login", "2018-05-20")
RunFunc("rebate")


