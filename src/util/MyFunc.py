import datetime
import psycopg2
from pymongo import MongoClient

class BigUtil:
	def func1():
		print("func1")
		
	def pypg():
		conn = psycopg2.connect(database="postgres", user="postgres", password="123456", host="127.0.0.1", port="5432")
		print("Opened database successfully")
		cur = conn.cursor()
		cur.execute("SELECT ctfid, name, address, mobile  from personcheck")
		rows = cur.fetchmany(1000) #cur.fetchall()
		for row in rows:
		   print("ID = ", row[0])
		   print("NAME = ", row[1])
		   print("ADDRESS = ", row[2])
		   print("MOBILE = ", row[3], "\n")
		   BigUtil.insmon(row[0],row[1],row[2],row[3])
		conn.close()

	def insmon(id,name,address,mobile):
		conn = MongoClient('mongodb://lcc:lcc@ds121089.mlab.com:21089/lccdb')
		db = conn.lccdb  #db
		my_set = db.people  #table
		my_set.insert_one({"id":id,"name":name,"address":address,"mobile":mobile,"dt":datetime.datetime.now()})
		conn.close()