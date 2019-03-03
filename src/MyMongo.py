#!/usr/bin/env python
# -*- coding:utf-8 -*-
from pymongo import MongoClient
conn = MongoClient('mongodb://surrealism:dr0675@ds121089.mlab.com/lccdb')
db = conn.mydb  #11
my_set = db.test_set  #22
