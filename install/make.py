from alive_progress import alive_bar
from pathlib import Path
import mysql.connector
from mysql.connector import Error
import csv
import re
import time

#============================ EDIT MYSQL CONFIGURATION ============================
mysql_config = {
        'user': 'root',
        'password': '',
        'host': 'localhost',
        'database': 'devstore',
        'port': '3306',
        'ssl_disabled': True
    }
#================================== END OF EDIT ===================================

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def execute_sqlfile(cnx, filename):
	cursor = cnx.cursor()

	fd = open(filename, 'r', encoding="UTF-8")
	sqlFile = fd.read()
	fd.close()
	sqlCommands = re.split(';\n',sqlFile) #sqlFile.split(';')

	title = Path(filename).stem

	total = len(sqlCommands)
	with alive_bar(total, dual_line=True, title=title.ljust(15)) as bar:
		for command in sqlCommands:
			try:
			    if command.strip() != '':
			        cursor.execute(command)
			        cnx.commit()
			        time.sleep(0.05)
			except (Exception) as e :
				print(bcolors.WARNING + "Warning: Command skipped" + bcolors.ENDC, e)
			bar()
	cursor.close


#================================== MAIN SCRIPT ===================================

print(bcolors.HEADER + "DevStore Maker v1.0.0"+ bcolors.ENDC)

try:
	cnx = mysql.connector.connect(**mysql_config)
	if cnx.is_connected():
		print(bcolors.OKGREEN + 'connected to database' + bcolors.ENDC)

	print(bcolors.OKCYAN + 'create tables and erase data' + bcolors.ENDC)
	execute_sqlfile(cnx, 'sql_scripts/dev_store_db.sql')
	print(bcolors.OKCYAN + 'import data' + bcolors.ENDC)
	execute_sqlfile(cnx, 'sql_scripts/dev_store_data.sql')

	cnx.close()
	print(bcolors.OKGREEN + "🏁🏁🏁 Finished All 🏁🏁🏁" + bcolors.ENDC)

except Error as e:
	print(bcolors.FAIL + "mysql DB connection error" + bcolors.ENDC)
	print(e)




