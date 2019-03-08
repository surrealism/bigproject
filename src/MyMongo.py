#!/usr/bin/env python
# -*- coding:utf-8 -*-
import datetime
import logging
import socket
import random
from flask import request
from pymongo import MongoClient

def Unicode():
    val = random.randint(0x4e00, 0x9fbf)
    return unichr(val)
	
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

my_set.insert({"d":datetime.datetime.now(),"ip":get_my_ip(),"zh":Unicode()+Unicode()+Unicode()})
for i in my_set.find():
    print(i)
