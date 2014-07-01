import sqlite3
print "start process. sqlite: " + sqlite3.sqlite_version
conn = sqlite3.connect('bundesliga')
c = conn.cursor()

def calculate(id):
	goals = 0
	counterGoals = 0
	growth = 0
	for row in c.execute("""SELECT * FROM v_match WHERE team_id = """ + str(id) + """ LIMIT 3;"""):
		goals += row[2]
		counterGoals += row[3]
		
	lost = 0
	for row in c.execute("""SELECT goals,cgoals FROM v_match WHERE team_id = """ + str(id) + """ LIMIT 5;"""):
		if row[1] > row[0]:
			lost += 1

	return ('\n' + 
		str(id) + 
		',' + str(goals) + 
		',' + str(counterGoals) + 
		',' + str(growth) +
		',' + str(lost))
	
def writeFile(fileName, data):
	f = open(fileName + '.arff','w')
	f.write('@RELATION data\n')
	f.write('@ATTRIBUTE team NUMERC\n')
	f.write('@ATTRIBUTE tore NUMERIC\n')
	f.write('@ATTRIBUTE gegentore3 NUMERIC\n')
	f.write('@ATTRIBUTE steigerung3 NUMERIC\n')
	f.write('@ATTRIBUTE niederlagen5 NUMERIC\n')
	f.write('@DATA')
	f.write(data)
	
writeFile('calc', calculate(1) + calculate(2))


c.close()
