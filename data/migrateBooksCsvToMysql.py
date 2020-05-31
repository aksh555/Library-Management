import mysql.connector
import csv

#enter your username and password
cnx = mysql.connector.connect(user='', password='',database='LMS',charset='utf8')
cursor = cnx.cursor(prepared=True)

with open('books1.csv',  encoding='windows-1252') as csvfile:
	readCSV = csv.reader(csvfile, delimiter=',')	
	author_id = 0
	for row in readCSV:
		query = 'Insert into BOOK values(%s,%s,%s)'
		isbn = row[0]
		title = row[2]
		authors = row[3]
		cursor.execute(query,(isbn,title,False))
		authorList = authors.split(",")
		for author in authorList:
			query1 = 'Insert into AUTHORS values(%s,%s)'				
			author_id = author_id+1
			cursor.execute(query1,(author_id,author))
			query2 = 'Insert into BOOK_AUTHORS values(%s,%s)'
			cursor.execute(query2,(isbn,author_id))

cnx.commit()
cursor.close()
cnx.close()
			
			
	
