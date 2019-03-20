import psycopg2
class BigUtil:
	def func1():
		print("func1")
		
	def pypg():
		conn = psycopg2.connect(database="postgres", user="postgres", password="123456", host="127.0.0.1", port="5432")
		print("Opened database successfully")
		cur = conn.cursor()
		cur.execute("SELECT ctfid, name, address, mobile  from personcheck")
		rows = cur.fetchmany(10) #cur.fetchall()
		for row in rows:
		   print("ID = ", row[0])
		   print("NAME = ", row[1])
		   print("ADDRESS = ", row[2])
		   print("MOBILE = ", row[3], "\n")
		conn.close()