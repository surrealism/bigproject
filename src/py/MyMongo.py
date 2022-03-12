#!/usr/bin/env python
# -*- coding:utf-8 -*-
import datetime
import logging
import socket
import random
from flask import request
from pymongo import MongoClient
from util.MyFunc import BigUtil
import uuid

def get_mac_address():
	mac=uuid.UUID(int = uuid.getnode()).hex[-12:]
	return ":".join([mac[e:e+2] for e in range(0,11,2)])

def Unicode():
    val = random.randint(0x4e00, 0x9fbf)
    return chr(val)
	
def get_request_ip():
	'''获取请求方的ip'''
	try:
		ip = request.remote_addr
		logging.error('------ ip = %s ------' % ip)
		return ip
	except Exception as e:
		logging.error(e)

def get_my_ip():
	'''获取本机的ip'''
	try:
		name = socket.getfqdn(socket.gethostname())
		ip = socket.gethostbyname(name)
		logging.debug('------ ip = %s ------' % ip)
		return ip
	except Exception as e:
		logging.error(e)

#多网卡情况下，根据前缀获取IP（Windows 下适用）
def GetLocalIPByPrefix(prefix):
	localIP = ''
	for ip in socket.gethostbyname_ex(socket.gethostname())[2]:
		if ip.startswith(prefix):
			localIP = ip	
	return localIP

conn = MongoClient('mongodb://lcc:lcc@ds121089.mlab.com:21089/lccdb')
db = conn.lccdb  #11
my_set = db.foo  #22

BigUtil.func1()
BigUtil.pypg()

ip = GetLocalIPByPrefix("10.") #get_my_ip()
mac = get_mac_address()
for num in range(1,100):
	zh = ''
	zhmaxnum = random.randint(1,10)
	for zhnum in range(1,zhmaxnum):
		zh += Unicode()
#	my_set.insert_one({"d":datetime.datetime.now(),"ip":ip,"mac":mac,"num":num,"zh":zh})

#for i in my_set.find():
#    print(i)
	
#for i in my_set.find({"num":{"$gt":50}}):
#    print(i)	
