from alive_progress import alive_bar
from pathlib import Path
import mysql.connector
from mysql.connector import Error
import csv
import re
import time
import sqlparse

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


def execute_sqlfile(cnx, fileName):
    with open(fileName, 'r', encoding="UTF-8") as fd:
        sqlCommands = sqlparse.split(fd.read())
        title = Path(fileName).stem
        total = len(sqlCommands)
        cursor = cnx.cursor()

        with alive_bar(total, dual_line=True, title=title.ljust(15)) as bar:
            for sqlCommand in sqlCommands:
                cursor.execute(sqlCommand)
                cnx.commit()
                time.sleep(0.05)
                bar()
        cursor.close
#================================== MAIN SCRIPT ===================================

print(bcolors.HEADER + "DevStore Maker v1.0.0"+ bcolors.ENDC)

cnx = None

try:
	cnx = mysql.connector.connect(**mysql_config)
except Error as e:
	print(bcolors.FAIL + "mysql DB connection error" + bcolors.ENDC)
	print(e)
else:
	if cnx.is_connected():
		print(bcolors.OKGREEN + 'connected to database' + bcolors.ENDC)

	print(bcolors.OKCYAN + 'create tables and erase data' + bcolors.ENDC)
	execute_sqlfile(cnx, 'sql_scripts/dev_store_db.sql')
	print(bcolors.OKCYAN + 'import data' + bcolors.ENDC)
	execute_sqlfile(cnx, 'sql_scripts/dev_store_data.sql')

finally:
    if cnx is not None and cnx.is_connected():
    	cnx.close()

print(bcolors.OKGREEN + "🏁🏁🏁 Finished All 🏁🏁🏁" + bcolors.ENDC)



