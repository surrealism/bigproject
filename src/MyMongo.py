#!/usr/bin/env python
# -*- coding:utf-8 -*-
import datetime
import logging
import socket
import random
from flask import request
from pymongo import MongoClient
from util.MyFunc import BigUtil

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
		logging.error('------ ip = %s ------' % ip)
		return ip
	except Exception as e:
		logging.error(e)
			
conn = MongoClient('mongodb://lcc:lcc@ds121089.mlab.com:21089/lccdb')
db = conn.lccdb  #11
my_set = db.foo  #22

BigUtil.func1()

ip = get_my_ip()
for num in range(1,100):
	zh = ''
	zhmaxnum = random.randint(1,10)
	for zhnum in range(1,zhmaxnum):
		zh += Unicode()
#	my_set.insert_one({"d":datetime.datetime.now(),"ip":ip,"num":num,"zh":zh})

#for i in my_set.find():
#    print(i)
	
for i in my_set.find({"num":{"$gt":50}}):
    print(i)	
