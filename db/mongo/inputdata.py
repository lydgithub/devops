#!/usr/bin/python
#-*- coding:utf-8 -*-

import pymongo
import time
from random import Random
def random_str(randomlength=8):
	str = ''
	chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
	length = len(chars) - 1
	random = Random()
	for i in range(randomlength):
		str+=chars[random.randint(0, length)]
	return str

def inc_data(conn):
	db = conn.mycol
	collection = db.users
	for i in range(100000):
		str = ''
		chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
		length = len(chars) - 1
		random = Random()
		for i in range(15):
			str+=chars[random.randint(0, length)]
			string = str
			collection.insert({"name" : string, "dob" : "01-01-1991", "gender" : "M", "contact" : "987654321", "user_name" : string, "address" : "hangzhou"+string})

if __name__ =='__main__':
	conn = pymongo.MongoClient(host='127.0.0.1',port=27018)
	StartTime = time.time()
	print "===============$inc==============="
	print "StartTime : %s" %StartTime
	inc_data(conn)
	EndTime = time.time()
	print "EndTime : %s" %EndTime
	CostTime = round(EndTime-StartTime)
	print "CostTime : %s" %CostTime
