import sqlite3

import_file_name = "data/pubmed/descriptor.txt"
cell_separator = "|||"
lines = []
insert_query = "INSERT INTO descriptor (pmid, descriptorid, descriptorterm) VALUES (?, ?, ?);"
db_connection = sqlite3.connect("sqlite/descriptor.sqlite")
db_cursor = db_connection.cursor()
db_cursor.execute("CREATE TABLE descriptor (pmid INTEGER, descriptorid TEXT, descriptorterm TEXT);")
db_cursor.execute("BEGIN TRANSACTION")
with open(import_file_name, 'r') as import_file:
	for line in import_file:
		cleaned_columns = [column.strip() for column in line.split(cell_separator)]
		db_cursor.execute(insert_query, tuple(cleaned_columns))

db_connection.commit()
db_cursor.execute("VACUUM;")
db_cursor.close()
db_connection.close()
