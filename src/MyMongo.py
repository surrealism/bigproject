#!/usr/bin/env python
# -*- coding:utf-8 -*-
import datetime
from pymongo import MongoClient
import logging
from flask import request

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

my_set.insert({"d":datetime.datetime.now(),"ip":get_request_ip()})
for i in my_set.find():
    print(i)
