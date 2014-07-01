import sqlite3
print "start process. sqlite: " + sqlite3.sqlite_version
conn = sqlite3.connect('bundesliga')
c = conn.cursor()

def sumFirst3Goals(id):
	goals = 0
	counterGoals = 0
	growth = 0
	for row in c.execute("""SELECT * FROM v_match WHERE team_id = """ + str(id) + """ LIMIT 3;"""):
		goals += row[2]
		counterGoals += row[3]
	return ('\n' + str(id) + ',' + str(goals) + ',' + str(counterGoals) + ',' + str(growth))

# mach mal die datei..
f = open('import.arff','w')
f.write('@RELATION data\n')
f.write('@ATTRIBUTE team NUMERC\n')
f.write('@ATTRIBUTE tore NUMERIC\n')
f.write('@ATTRIBUTE gegentore NUMERIC\n')
f.write('@ATTRIBUTE steigerung NUMERIC\n')
f.write('@DATA')

f.write(sumFirst3Goals(1))
f.write(sumFirst3Goals(2))


c.close()
